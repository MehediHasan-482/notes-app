# 📝 NoteNest — Flutter Notes App

A clean, minimal notes application built with Flutter, featuring secure authentication and real-time cloud storage.

---

## ✨ Features

- 🔐 **Authentication** — Email/password login & registration via Supabase Auth
- 📋 **Notes Management** — Create, view, and delete personal notes
- ☁️ **Cloud Storage** — All notes synced to Supabase (PostgreSQL)
- 🔒 **Row Level Security** — Each user can only access their own notes
- 💅 **Clean UI** — Pastel card design with smooth animations
- 🌀 **Splash Screen** — Shown only on first launch

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles, separated into three distinct layers:

```
lib/
├── core/                        # App-wide config
│   ├── constants/               # Supabase keys, shared pref keys
│   ├── routes/                  # GoRouter navigation setup
│   └── theme/                   # App color, typography, component themes
│
├── data/                        # Data Layer
│   ├── datasources/             # Supabase API calls
│   └── repositories/            # Repository implementations
│
├── domain/                      # Domain Layer (pure Dart, no Flutter)
│   ├── entities/                # NoteEntity, UserEntity
│   ├── repositories/            # Abstract repository interfaces
│   └── usecases/                # Business logic (Login, AddNote, etc.)
│
└── presentation/                # Presentation Layer
    ├── bindings/                # GetX dependency injection
    ├── controllers/             # AuthController, NotesController
    └── pages/                   # Splash, Login, Register, Home, AddNote
```

---

## 🛠️ Tech Stack

| Category | Package |
|---|---|
| State Management | [get ^4.6.6](https://pub.dev/packages/get) |
| Navigation | [go_router ^13.2.0](https://pub.dev/packages/go_router) |
| Backend / Database | [supabase_flutter ^2.3.4](https://pub.dev/packages/supabase_flutter) |
| Local Storage | [shared_preferences ^2.2.2](https://pub.dev/packages/shared_preferences) |
| Date Formatting | [intl ^0.19.0](https://pub.dev/packages/intl) |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.9.2`
- A free [Supabase](https://supabase.com) account
- Git

---

### Step 1 — Clone the repository

```bashhttps://github.com/MehediHasan-482/notes-app.git
git clone 
cd notes_app
```

---

### Step 2 — Set up Supabase

1. Go to [supabase.com](https://supabase.com) and create a **New Project**
2. Open the **SQL Editor** from the left sidebar
3. Paste and run the following SQL to create the notes table:

```sql
create table if not exists public.notes (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  title text not null,
  description text not null,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

alter table public.notes enable row level security;

create policy "Users can view their own notes"
  on public.notes for select
  using (auth.uid() = user_id);

create policy "Users can insert their own notes"
  on public.notes for insert
  with check (auth.uid() = user_id);

create policy "Users can delete their own notes"
  on public.notes for delete
  using (auth.uid() = user_id);
```

4. Go to **Settings → API** and copy:
   - **Project URL**
   - **anon public** key

---

### Step 3 — Add your Supabase credentials

Open `lib/core/constants/app_constants.dart` and replace the placeholder values:

```dart
class AppConstants {
  static const String supabaseUrl = 'https://iximkdfetpomxolfkxve.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_XJV47jJc2f5_JZX6Vqnmiw_kY_oC0K-';
  static const String splashShownKey = 'splash_shown';
}
```

---

### Step 4 — Install dependencies & run

```bash
flutter pub get
flutter run
```

---

## 📱 App Pages

| Page | Description |
|---|---|
| **Splash Screen** | Animated intro screen shown only on first launch |
| **Login** | Sign in with email & password |
| **Register** | Create account with name, email & password |
| **Home** | View all your notes with pull-to-refresh |
| **Add,Delete,Fatch Note** | Write a new note with title and description |

---

## 🗂️ Git Commit History

```
feat: initial flutter project setup
feat: Supabase integration
feat: splash screen and app logo
feat: registation and login
feat: final authentication
feat: notes add,delete,get
chore: README and finalize project
```

---

## 📸 Screenshots

> *(Add screenshots here after running the app)*

| Splash       |Registation        | Login       | Home       | Add Note  |
|--------------|-------------------|-------------|------------|-----------|
| ![splash](https://github.com/user-attachments/assets/b3f7924a-5a03-4f42-8a92-c8427c8991c2) | ![registation](https://github.com/user-attachments/assets/588f124a-2147-41f4-b8ef-3b266b77e328) | ![login](https://github.com/user-attachments/assets/71774a08-fbce-47e3-ba82-49d71554905f) | ![home](https://github.com/user-attachments/assets/3210c7f7-4c5e-45b3-9052-bebe88543731) | ![add](https://github.com/user-attachments/assets/d5bb6a57-d383-48ed-95ea-80473799e617) |

---

## 👤 Author

**Your Name**  
📧 mehedi89345506@gmail.com
🔗 [github.com/MehediHasan-482](https://github.com/MehediHasan-482)

---

## 📄 License

This project was built as part of a technical assessment for **Caretutors**.
