package com.tutorlink.model;

import jakarta.persistence.*;
// Admin model class - extends User
@Entity
@DiscriminatorValue("ADMIN")
public class Admin extends User {
    public Admin() {
        super();
    }
    public Admin(String fullName, String email, String password, String phone) {
        super(fullName, email, password, phone);
    }
    // polymorphism - override dashboard page
    @Override
    public String getDashboardPage() {
        return "admin/dashboard";
    }
    // polymorphism - override profile summary
    @Override
    public String getProfileSummary() {
        return "System Administrator | " + getFullName();
    }
}
