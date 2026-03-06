# Ocean View Resort - Online Room Reservation System

A complete, enterprise-grade, distributed web application built with Java Servlets, JSP, MySQL, and a modern Bootstrap 5 dark theme UI.

## Features
- **MVC Architecture & 10 Design Patterns:** Singleton, Factory, Adapter, Strategy, Builder, Facade, Observer, DAO, Repository.
- **Roles:** Admin, Receptionist, Manager, Accountant, Guest.
- **OTP Authentication system** with BCrypt hashing and account locking.
- **Reservation Workflow:** Availability checks, Overlap prevention, Search functionality.
- **Billing & Payments:** Invoice generation, Strategy-based pricing, Adapter-backed online/offline payments.
- **Admin Panel:** Complete CRUD operations for settings, rooms, and viewing audit logs.
- **Beautiful UI:** Glassmorphism, Neon glow, AOS animations.

## Step-by-Step Setup Guide

### 1. Database Setup (XAMPP / MySQL)
1. Start **XAMPP** and ensure **MySQL** and **Apache** are running.
2. Open **phpMyAdmin** (http://localhost/phpmyadmin).
3. Create a new database named `ovr_db`.
4. Import `schema.sql` into `ovr_db` to create tables.
5. Import `seed.sql` to populate default settings, room types, rooms, and the first Admin account.
   > **Note:** The default Admin user is `admin` with the password `admin123`.

### 2. Configuration & Dependencies
1. Open `src/java/DBConfig.java` to verify the JDBC URL, Username, and Password (`root` / `""` by default).
2. Ensure your NetBeans project has the following libraries added to `Libraries` (or `web/WEB-INF/lib` if configuring manually):
   - MySQL Connector/J
   - jBCrypt (`org.mindrot.jbcrypt.BCrypt`)
   - JSTL (JavaServer Pages Standard Tag Library)
   - Java EE / Jakarta EE API (Servlets)
3. **Clean and Build** the project in NetBeans to generate the WAR file.

### 3. Deployment
1. Start **Apache Tomcat** via NetBeans or standalone.
2. Deploy the generated WAR file via the NetBeans IDE or place it into the `webapps` folder of your Tomcat installation.
3. Open the application URL in your browser: `http://localhost:8080/Ocean_View_Resort_Thadshanyaa/`

### 4. Application Testing
1. **Authentication:** Go to Login. Try logging in with `admin` and `admin123`. The system will throw an OTP.
   - For dev purposes, the OTP is printed directly on the page under a yellow warning box. 
   - Enter the OTP to finalize login.
2. **Bookings:** Click "Check Availability", enter dates, proceed to "New Booking", select a room, and check out.
3. **Billing:** Copy your reservation number, go back to your dashboard or "Find Reservation", click your booking, and select **Generate Bill / Check-Out**.
4. **Payments:** View the generated invoice and click "Make Payment". Select "Online Gateway" to preview the Adapter dummy flow or "Card/Cash" for offline manual entry.
5. **Admin Panel:** As `admin`, click "Admin Panel" on your sidebar. Create new room types, rooms, configure tax rates, and check the Audit Log tracking all your previous actions!

Enjoy the Ocean View experience.
