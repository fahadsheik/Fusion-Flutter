# Fusion ERP Frontend - Flutter Version 🚀

This is the frontend of **Fusion - IIITDMJ's ERP Portal**, re-developed using **Flutter** for a modern, cross-platform UI experience.

---

## 🛠️ Tech Stack

- **Flutter** for UI development  
- **Provider / Riverpod** for state management  
- **Material Icons** for icons  
- **http**, **flutter_hooks**, etc. (check `pubspec.yaml`)  
- **Dart Formatter** for formatting  
- **Very Good Analysis** or Lint for static code checks  

---

## 🔧 Setting up the Project

1. **Fork the Repository**  
   - Go to GitHub and click on **Fork**  
   - ❗ **Uncheck** "Copy `main` branch only" so you get all branches

2. **Clone your forked repo**
   ```bash
   git clone https://github.com/your-username/your-forked-repo.git
   cd your-forked-repo
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

   ✅ Make sure the backend server is running before starting the app for full functionality.

---

## 📁 Project Structure

```
lib/
├── main.dart                      # Entry point
├── routes/                        # Route definitions
├── constants/api_routes.dart      # API endpoints
├── components/                    # Global widgets
├── pages/                         # Global screens
└── modules/                       # Module-specific folders
     └── module-name/
         ├── components/           # Module-specific widgets
         ├── styles/               # Custom styles (if any)
         └── screens/              # Module pages
```

---

## 🌐 Accessing User State Example

```dart
final username = context.watch<UserProvider>().username;
final role = context.watch<UserProvider>().role;

Text('$username ($role)')
```

---

## 🎨 Style Guide

- Folder names → `kebab-case`  
- File names → `camelCase.dart`  
- Constants → `UPPER_SNAKE_CASE`  
- Widgets → `PascalCase`  
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart/style)  

---

## 🚀 How to Contribute

1. **Fork the Repository**  
   - Click **Fork** on GitHub  
   - ❗ Make sure to **uncheck "Copy main branch only"**

2. **Clone your Fork**
   ```bash
   git clone https://github.com/your-username/your-forked-repo.git
   cd your-forked-repo
   ```

3. **Checkout to Your Target Branch**
   ```bash
   git checkout target-branch-name
   ```

4. **Add and Push Your Code**
   ```bash
   git add .
   git commit -m "Your changes description"
   git push origin target-branch-name
   ```

5. **Create a Pull Request**
   - Go to your repo on GitHub  
   - Click **Compare & pull request**  
   - Make sure the base branch is correct  
   - Submit the PR 🚀

> 🔍 Your PR will be reviewed and verified. Once approved, it’ll be merged into the project.
