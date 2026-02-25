# 🎮 Velocity Clash – AI Battle Arena  

> A modern AI-powered 2D Pong-style battle game built using C++ and raylib.

---

## 🚀 Project Overview

**Velocity Clash – AI Battle Arena** is a real-time 2D arcade game inspired by the classic Pong concept, redesigned with structured architecture, AI paddle logic, smooth collision mechanics, and a professional build system.

This project demonstrates strong fundamentals in:

- 🎯 Object-Oriented Programming (OOP)
- ⚡ Real-time game loop architecture
- 🧠 Basic Artificial Intelligence logic
- 💥 Collision detection algorithms
- 🎨 2D graphics rendering using raylib
- 🛠 Custom Makefile build automation

---

## 🎮 Gameplay Features

- ✅ Player-controlled paddle
- ✅ AI-controlled opponent paddle
- ✅ Ball physics with dynamic reflection
- ✅ Real-time score tracking
- ✅ Smooth frame rendering
- ✅ Debug and Release build modes
- ✅ Structured and maintainable codebase

---

## 🧠 AI Logic Implementation

The opponent paddle uses simple tracking logic:

- If the ball’s Y position is above the paddle → move up  
- If the ball’s Y position is below the paddle → move down  

This creates competitive gameplay without requiring external AI frameworks.

---

## 🏗 Game Architecture

The project follows a structured game development pattern:

### 1️⃣ Initialization Phase
- Create window
- Initialize paddles and ball
- Set initial score

### 2️⃣ Game Loop
- Handle input
- Update AI movement
- Update ball position
- Detect collisions
- Update score
- Render objects

### 3️⃣ Cleanup Phase
- Close window
- Free allocated resources

---

## 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| Language | C++ (C++14 Standard) |
| Graphics Library | raylib |
| Compiler | g++ |
| Build System | Custom Makefile |
| Platform | Windows Desktop |

---

## 📂 Project Structure
