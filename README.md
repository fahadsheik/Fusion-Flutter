# Fusion Hostel Management App

A Flutter-based mobile application for managing hostel activities with role-based access for students, wardens, caretakers, and superadmins.

## Features

### 1. *Authentication & Role-Based Access*
- Login/Signup for four types of users:
    - *Student*
    - *Warden*
    - *Caretaker*
    - *SuperAdmin*
- Different UI and functionalities rendered based on the user's role.

---

### 2. *Home Page - Hostel Management Panel*
Unified dashboard for students and staff with expandable options:

#### a. *View Allotted Room*
- *Student*: View current room and roommate details.
- *Warden*: View room assignments of all students.

#### b. *Guest Room*
- *Student*: Request guest room for relatives.
- *Warden*: Approve/reject guest room requests.

#### c. *Complaints*
- *Student*: Raise complaints about infrastructure or services.
- *Caretaker*: View, mark as resolved, and update complaints.
- *Warden*: Monitor and reassign unresolved complaints.

#### d. *Notice Board*
- *Warden & SuperAdmin*: Upload campus/hostel notices.
- *Student & Caretaker*: View notices.

#### e. *View Fines*
- *Student*: View any fines imposed.
- *Warden*: Issue fines for violations (e.g., curfew, damages).

#### f. *Leaves*
- *Student*: Apply for leave with reason and duration.
- *Warden*: Approve or deny leave requests.
- *SuperAdmin*: Audit leave records across hostels.

---

## Actors and Functional Scope

| Feature              | Student | Warden | Caretaker | SuperAdmin |
|----------------------|---------|--------|-----------|-------------|
| View Room            | Yes     | Yes    | No        | No          |
| Guest Room Request   | Yes     | Yes    | No        | No          |
| File Complaints      | Yes     | No     | Yes (view) | No         |
| Issue Fines          | No      | Yes    | No        | Yes         |
| View Notices         | Yes     | Yes    | Yes       | Yes         |
| Post Notices         | No      | Yes    | No        | Yes         |
| Apply for Leave      | Yes     | Yes (review) | No  | Yes (audit) |
| Access All Records   | No      | Partial| Partial   | Full        |

---

## Folder Structure