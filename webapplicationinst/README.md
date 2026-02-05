# Training Portal Web Application

A web application similar to visualpath.in for online training management with student login functionality.

## Features

- Student Registration and Login
- Course Catalog
- Student Dashboard
- Oracle Database Integration
- Responsive Design
- Session Management

## Technology Stack

- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: Java Servlets (Java EE)
- **Database**: Oracle Database
- **Server**: Apache Tomcat
- **DataSource**: OracleDS (JNDI)

## Project Structure

```
training-website/
├── META-INF/
│   └── context.xml          # Tomcat DataSource configuration
├── WEB-INF/
│   ├── web.xml              # Web application deployment descriptor
│   └── classes/
│       └── com/trainingportal/
│           ├── DatabaseUtil.java
│           ├── Student.java
│           ├── LoginServlet.java
│           ├── RegisterServlet.java
│           ├── LogoutServlet.java
│           └── CoursesServlet.java
├── css/
│   └── style.css
├── js/
│   └── script.js
├── database/
│   └── schema.sql           # Oracle database schema
├── index.html
├── login.html
├── register.html
├── courses.html
└── dashboard.html
```

## Prerequisites

1. **Java Development Kit (JDK)** 8 or higher
2. **Apache Tomcat** 8.5 or higher
3. **Oracle Database** (11g or higher) or Oracle XE
4. **Oracle JDBC Driver** (ojdbc8.jar or ojdbc11.jar)

## Database Setup

1. **Create Oracle Database User** (if needed):
   ```sql
   CREATE USER training_user IDENTIFIED BY your_password;
   GRANT CONNECT, RESOURCE TO training_user;
   GRANT CREATE SESSION TO training_user;
   GRANT UNLIMITED TABLESPACE TO training_user;
   ```

2. **Run the Database Schema**:
   - Connect to Oracle database as your user
   - Execute the SQL script: `database/schema.sql`
   ```bash
   sqlplus training_user/your_password@localhost:1521/XE
   SQL> @database/schema.sql
   ```

3. **Verify Tables Created**:
   ```sql
   SELECT table_name FROM user_tables;
   ```
   You should see: STUDENTS, COURSES, ENROLLMENTS

## Configuration

### 1. Update Oracle DataSource Configuration

Edit `META-INF/context.xml` and update the following:

```xml
<Resource name="jdbc/OracleDS"
          ...
          url="jdbc:oracle:thin:@localhost:1521:XE"
          username="training_user"
          password="your_password"
          .../>
```

Replace:
- `localhost`: Your database host
- `1521`: Your database port
- `XE`: Your Oracle SID (XE for Oracle Express, ORCL for Enterprise, etc.)
- `training_user`: Your database username
- `your_password`: Your database password

### 2. Add Oracle JDBC Driver to Tomcat

Copy the Oracle JDBC driver to Tomcat's lib directory:
```bash
cp ojdbc8.jar /path/to/tomcat/lib/
```

Or download from: https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html

## Building the WAR File

### Option 1: Using the Build Script

```bash
chmod +x build.sh
./build.sh
```

### Option 2: Manual Build

1. **Compile Java Classes**:
   ```bash
   # Create classes directory
   mkdir -p WEB-INF/classes
   
   # Compile with servlet-api.jar and ojdbc jar in classpath
   javac -cp "/path/to/tomcat/lib/servlet-api.jar:/path/to/ojdbc8.jar" \
         -d WEB-INF/classes \
         WEB-INF/classes/com/trainingportal/*.java
   ```

2. **Create WAR File**:
   ```bash
   jar -cvf training-portal.war *
   ```

## Deployment

1. **Deploy to Tomcat**:
   - Copy `training-portal.war` to Tomcat's `webapps` directory
   ```bash
   cp training-portal.war /path/to/tomcat/webapps/
   ```

2. **Start Tomcat**:
   ```bash
   /path/to/tomcat/bin/startup.sh    # Linux/Mac
   /path/to/tomcat/bin/startup.bat   # Windows
   ```

3. **Access the Application**:
   - Open browser and navigate to: `http://localhost:8080/training-portal/`

## Testing

### Test Credentials

The database schema includes two test accounts:

1. **Account 1**:
   - Email: test@example.com
   - Password: test123

2. **Account 2**:
   - Email: demo@example.com
   - Password: demo123

### Test the Application

1. Visit the home page
2. Click "Student Login"
3. Login with test credentials
4. Access the dashboard
5. Try registering a new student

## Troubleshooting

### Common Issues

1. **ClassNotFoundException: oracle.jdbc.OracleDriver**
   - Solution: Ensure ojdbc8.jar is in Tomcat's lib directory

2. **Cannot get connection from DataSource**
   - Solution: Check Oracle database is running
   - Verify connection details in context.xml
   - Check Oracle listener status: `lsnrctl status`

3. **404 Error - Page Not Found**
   - Solution: Ensure WAR file is properly deployed
   - Check Tomcat logs in `logs/catalina.out`

4. **Login fails with "Invalid credentials"**
   - Solution: Verify database tables exist and have data
   - Run: `SELECT * FROM students;`

5. **ORA-12154: TNS:could not resolve the connect identifier**
   - Solution: Check Oracle SID in connection URL
   - Verify tnsnames.ora configuration

### Checking Logs

- **Tomcat Logs**: `/path/to/tomcat/logs/catalina.out`
- **Application Logs**: Check servlet errors in Tomcat logs

## Security Notes

**IMPORTANT for Production**:

1. **Password Hashing**: Current implementation stores plain text passwords
   - Implement BCrypt or similar for password hashing
   - Update LoginServlet and RegisterServlet

2. **SQL Injection Prevention**: Uses PreparedStatements (already implemented)

3. **HTTPS**: Deploy with SSL/TLS in production

4. **Session Security**: 
   - Set secure flag on cookies
   - Implement CSRF protection

5. **Input Validation**: Add server-side validation

## Features to Add (Future Enhancements)

- Password reset functionality
- Email verification
- Course enrollment system
- Progress tracking
- Certificate generation
- Payment integration
- Admin panel
- File upload for assignments
- Live class integration

## Support

For issues or questions:
- Email: info@visualpath.in
- Phone: +91 9999999999

## License

This is a demonstration project for educational purposes.

## Version History

- **v1.0** (2024-02-05): Initial release
  - Student login/registration
  - Course catalog
  - Basic dashboard
  - Oracle database integration
