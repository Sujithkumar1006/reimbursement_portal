# Reimbursement Portal (Ruby on Rails monolith)

A simple reimbursement management system where employees can submit expense bills and administrators can manage employees and approve or reject reimbursement requests.

---

## Features

### Authentication
- Email and password based login
- Role based access (`admin`, `employee`)

### Admin
- View all employees
- Create, update and delete employees
- View all reimbursement requests
- Approve or reject reimbursement requests

### Employee
- Submit reimbursement bills
- View their submitted bills
- Track bill status

---

## Tech Stack

- Ruby on Rails
- PostgreSQL
- ERB
- HTML / CSS

---

## Database Design

The system separates authentication from employee profile information.

### Users

Stores authentication and identity information.

Fields:
- first_name
- last_name
- email
- password_digest
- role

Associations:
- has_one :employee
- has_many :bills

---

### Employees

Stores organization specific employee details.

Fields:
- designation
- department_id
- user_id

Associations:
- belongs_to :user
- belongs_to :department

---

### Departments

Stores department information.

Fields:
- name

Associations:
- has_many :employees

---

### Bills

Stores reimbursement requests submitted by employees.

Fields:
- bill_type (Food / Travel / Others)
- amount
- status (Pending / Approved / Rejected)
- user_id

Associations:
- belongs_to :user

---

## Model Relationships

User
 ├── has_one Employee
 └── has_many Bills

Employee
 ├── belongs_to User
 └── belongs_to Department

Department
 └── has_many Employees

Bill
 └── belongs_to User

---

## Default Behavior

When an admin creates an employee:

- A `User` record is automatically created
- Role is set to `employee`
- Default password is generated randomly and stored

Employees can log in using their email and this password.

---

## Setup

Install dependencies

bundle install

Setup database

rails db:create  
rails db:migrate  
rails db:seed

Start server

rails server

Open in browser

http://localhost:3000

---

## Author

Sujith
