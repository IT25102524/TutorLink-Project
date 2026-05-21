package com.tutorlink.model;
import jakarta.persistence.*;

// PrimarySubject class - extends Subject
@Entity
@DiscriminatorValue("PRIMARY")
public class PrimarySubject extends Subject {

    public PrimarySubject() {
        super();
    }

    public PrimarySubject(String name) {
        super(name, "Grade 1 - 5");
    }

    // override subject type
    @Override
    public String getSubjectType() {
        return "Primary";
    }

    //override display info
    @Override
    public String getDisplayInfo() {
        return getName() + " | Primary (Grade 1-5)"
                + (getMedium() != null ? " | " + getMedium() : "")
                + (getCategory() != null ? " | " + getCategory() : "");
    }
}
