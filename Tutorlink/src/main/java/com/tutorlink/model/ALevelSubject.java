package com.tutorlink.model;
import jakarta.persistence.*;

// ALevelSubject class - extends Subject
@Entity
@DiscriminatorValue("ALEVEL")

public class ALevelSubject extends Subject {

    public ALevelSubject() {
        super();
    }

    public ALevelSubject(String name) {
        super(name, "Grade 12 - 13");
    }

    // override subject type
    @Override
    public String getSubjectType() {
        return "A/L";
    }

    // override display info
    @Override
    public String getDisplayInfo() {
        return getName() + " | A/L (Grade 12-13)"
                + (getMedium() != null ? " | " + getMedium() : "")
                + (getCategory() != null ? " | " + getCategory() : "");
    }
}
