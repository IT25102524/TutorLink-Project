package com.tutorlink.repository;

import com.tutorlink.model.AvailabilitySlot; //Imports the AvailabilitySlot model class

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository; //Imports the @Repository annotation

import java.util.List; //Imports List to return multiple AvailabilitySlot objects

@Repository

//OOP Concept - INHERITANCE (The repository inherits CRUD methods from JpaRepository)
public interface AvailabilitySlotRepository extends JpaRepository<AvailabilitySlot, Integer> {

    //OOP Concept - ABSTRACTION 
    List<AvailabilitySlot> findByTutorIdOrderByDayAsc(int tutorId);
    List<AvailabilitySlot> findByTutorSubjectId(int tutorSubjectId);
    List<AvailabilitySlot> findByTutorIdAndStatus(int tutorId, String status);
}