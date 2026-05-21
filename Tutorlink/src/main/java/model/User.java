import jakarta.persistence.*;

// User base class - parent class for Student, Tutor and Admin
@Entity
@Table(name = "users")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "role", discriminatorType = DiscriminatorType.STRING)
public abstract class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int userId;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "role", insertable = false, updatable = false)
    private String role;

    @Column(name = "phone")
    private String phone;

    @Column(name = "status")
    private String status;

    public User() {
        this.status = "ACTIVE";
    }

    public User(String fullName, String email, String password, String phone) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.status = "ACTIVE";
    }

    // abstraction - subclasses return dashboard page
    public abstract String getDashboardPage();

    // abstraction - subclasses return profile summary
    public abstract String getProfileSummary();

    // information hiding - check password
    public boolean checkPassword(String inputPassword) {
        return inputPassword.equals(this.password);
    }

    // information hiding - check login status
    public boolean canLogin() {
        return "ACTIVE".equals(this.status);
    }

    // information hiding - show role name
    public String getRoleName() {
        if ("STUDENT".equals(role)) return "Student";
        if ("TUTOR".equals(role))   return "Tutor";
        if ("ADMIN".equals(role))   return "Administrator";
        return role;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
