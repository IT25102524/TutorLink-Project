package com.tutorlink.model;
import jakarta.persistence.*;

// OLevelSubject class - extends Subject
@Entity
@DiscriminatorValue("OLEVEL")

public class OLevelSubject extends Subject {

    public OLevelSubject() {
        super();
    }

    public OLevelSubject(String name) {
        super(name, "Grade 6 - 11");
    }

    // override subject type
    @Override
    public String getSubjectType() {
        return "O/L";
    }

    //override display info
    @Override
    public String getDisplayInfo() {
        return getName() + " | O/L (Grade 6-11)"
                + (getMedium() != null ? " | " + getMedium() : "")
                + (getCategory() != null ? " | " + getCategory() : "");
    }
}
