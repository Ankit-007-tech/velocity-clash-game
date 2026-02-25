#include <raylib.h>
#include <iostream>

const int SCREEN_WIDTH = 1200;
const int SCREEN_HEIGHT = 700;
const int MAX_SCORE = 5;

enum GameState { MENU, PLAYING, PAUSED, GAMEOVER };
GameState currentState = MENU;

int userPoints = 0;
int aiPoints = 0;

Color BackgroundColor = Color{15, 15, 40, 255};
Color AccentColor = Color{255, 70, 70, 255};
Color BallColor = ORANGE;

class GameBall {
public:
    float x, y;
    float speedX, speedY;
    int radius;

    void Draw() {
        DrawCircle(x, y, radius, BallColor);
    }

    void Update() {
        x += speedX;
        y += speedY;

        if (y - radius <= 0 || y + radius >= SCREEN_HEIGHT) {
            speedY *= -1;
        }

        if (x < 0) {
            aiPoints++;
            Reset();
        }

        if (x > SCREEN_WIDTH) {
            userPoints++;
            Reset();
        }
    }

    void Reset() {
        x = SCREEN_WIDTH / 2;
        y = SCREEN_HEIGHT / 2;
        speedX = (GetRandomValue(0,1) ? 6 : -6);
        speedY = (GetRandomValue(0,1) ? 6 : -6);
    }
};

class Paddle {
public:
    float x, y;
    float width, height;
    float speed;

    void Draw() {
        DrawRectangleRounded(Rectangle{x,y,width,height}, 0.9, 0, AccentColor);
    }

    void LimitMovement() {
        if (y < 0) y = 0;
        if (y + height > SCREEN_HEIGHT)
            y = SCREEN_HEIGHT - height;
    }
};

class PlayerBar : public Paddle {
public:
    void Update() {
        if (IsKeyDown(KEY_W)) y -= speed;
        if (IsKeyDown(KEY_S)) y += speed;
        LimitMovement();
    }
};

class ComputerBar : public Paddle {
public:
    void Update(float ballY, int difficulty) {
        float center = y + height/2;

        if (difficulty == 1) { // Easy
            if (center < ballY) y += speed * 0.6;
            if (center > ballY) y -= speed * 0.6;
        }
        else { // Hard
            if (center < ballY) y += speed;
            if (center > ballY) y -= speed;
        }

        LimitMovement();
    }
};

int main() {

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Velocity Clash - AI Battle Arena");
    SetTargetFPS(60);

    GameBall ball;
    ball.radius = 15;
    ball.x = SCREEN_WIDTH/2;
    ball.y = SCREEN_HEIGHT/2;
    ball.speedX = 6;
    ball.speedY = 6;

    PlayerBar player;
    player.width = 20;
    player.height = 100;
    player.x = SCREEN_WIDTH - 40;
    player.y = SCREEN_HEIGHT/2 - 50;
    player.speed = 7;

    ComputerBar ai;
    ai.width = 20;
    ai.height = 100;
    ai.x = 20;
    ai.y = SCREEN_HEIGHT/2 - 50;
    ai.speed = 6;

    int difficulty = 2; // 1 = Easy, 2 = Hard

    while (!WindowShouldClose()) {

        BeginDrawing();
        ClearBackground(BackgroundColor);

        if (currentState == MENU) {
            DrawText("VELOCITY CLASH", 380, 200, 60, AccentColor);
            DrawText("Press ENTER to Start", 420, 300, 30, WHITE);

            if (IsKeyPressed(KEY_ENTER))
                currentState = PLAYING;
        }

        else if (currentState == PLAYING) {

            if (IsKeyPressed(KEY_P))
                currentState = PAUSED;

            ball.Update();
            player.Update();
            ai.Update(ball.y, difficulty);

            if (CheckCollisionCircleRec({ball.x, ball.y}, ball.radius,
                {player.x, player.y, player.width, player.height}) ||
                CheckCollisionCircleRec({ball.x, ball.y}, ball.radius,
                {ai.x, ai.y, ai.width, ai.height})) {

                ball.speedX *= -1.1;  // Increase speed every hit
                ball.speedY *= 1.05;
            }

            if (userPoints == MAX_SCORE || aiPoints == MAX_SCORE)
                currentState = GAMEOVER;

            DrawLine(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT, GRAY);
            ball.Draw();
            player.Draw();
            ai.Draw();

            DrawText(TextFormat("%i", userPoints), SCREEN_WIDTH*3/4, 40, 50, WHITE);
            DrawText(TextFormat("%i", aiPoints), SCREEN_WIDTH/4, 40, 50, WHITE);
        }

        else if (currentState == PAUSED) {
            DrawText("GAME PAUSED", 450, 300, 40, YELLOW);
            DrawText("Press P to Resume", 440, 350, 20, WHITE);

            if (IsKeyPressed(KEY_P))
                currentState = PLAYING;
        }

        else if (currentState == GAMEOVER) {

            if (userPoints > aiPoints)
                DrawText("YOU WIN!", 470, 300, 50, GREEN);
            else
                DrawText("AI WINS!", 470, 300, 50, RED);

            DrawText("Press R to Restart", 430, 360, 25, WHITE);

            if (IsKeyPressed(KEY_R)) {
                userPoints = 0;
                aiPoints = 0;
                ball.Reset();
                currentState = MENU;
            }
        }

        EndDrawing();
    }

    CloseWindow();
    return 0;
}
