<<<<<<< HEAD
# FusionIIIT App

**FusionIIIT** is the official Institute Management Software of the **Indian Institute of Information Technology (IIIT)**. This mobile application acts as a companion to the FusionIIIT web platform, delivering key institute services directly to the fingertips of students, faculty, and staff.

---

## Overview

The FusionIIIT App is designed to streamline access to essential academic and administrative resources. Whether you're checking schedules, managing tasks, or staying updated with institute announcements, this app brings convenience and efficiency to the IIIT community—all from your mobile device.

---

## Features

- **Seamless Integration**: Syncs effortlessly with the FusionIIIT web platform.
- **User-Friendly Interface**: Intuitive design tailored for students, faculty, and staff.
- **On-the-Go Access**: Manage institute-related tasks anytime, anywhere.
- **Core Services**: Access timetables, notifications, and more in real time.

---

## Purpose

The app aims to enhance the institute experience by providing a mobile-first solution that complements the existing web-based FusionIIIT system, ensuring the IIIT community stays connected and informed.

---

## Contributing

We welcome contributions to the FusionIIIT App! Here's how you can get started:

1. **Fork the Repository**:  
   Start by forking the repository to your GitHub account.

2. **Clone the Repository**:  
   Clone your forked repository to your local machine:  

   ```bash
   git clone <your_forked_repository_url>
   cd fusion_app
   ```

3. **Creating Screens**:  
   Add a new folder under the `lib/screens` directory with the name of your module (`<module_name>`). Place all screen-related files for the module in this folder.

4. **Reusable Components**:  
   If you are creating reusable components, add them to the `utils` folder. Ensure the components are modular and well-documented.

5. **Submitting Changes**:  
   - Create a new branch for your feature or bug fix:  

     ```bash
     git checkout -b <branch_name>
     ```

   - Commit your changes with clear and concise messages:  

     ```bash
     git commit -m "Your commit message"
     ```

   - Push your branch to your forked repository:  

     ```bash
     git push origin <branch_name>
     ```

   - Submit a pull request for review.

---

## Setup and Run

Follow these steps to set up and run the project locally:

1. **Install Flutter**:  
   Ensure you have Flutter installed. Follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install) for your operating system.

2. **Install Dependencies**:  
   Run the following command to fetch all required dependencies:  

=======
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
>>>>>>> cd00228eb8e45d5c61f2b2b3815272304d19afe0
   ```bash
   flutter pub get
   ```

<<<<<<< HEAD
3. **Run the Application**:  
   Connect a device or start an emulator, then run:  

=======
4. **Run the app**
>>>>>>> cd00228eb8e45d5c61f2b2b3815272304d19afe0
   ```bash
   flutter run
   ```

<<<<<<< HEAD
---

*Built with ❤️ for the IIIT community by the Maitrek Patel😎.*
=======
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
>>>>>>> cd00228eb8e45d5c61f2b2b3815272304d19afe0
