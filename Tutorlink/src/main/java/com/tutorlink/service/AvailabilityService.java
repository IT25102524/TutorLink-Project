package com.tutorlink.service;
import com.tutorlink.model.AvailabilitySlot;
import com.tutorlink.model.Tutor;
import com.tutorlink.model.TutorSubject;
import com.tutorlink.model.User;
import com.tutorlink.repository.AvailabilitySlotRepository;
import com.tutorlink.repository.SubjectRepository;
import com.tutorlink.repository.TutorSubjectRepository;
import com.tutorlink.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
// Availability service - handles availability CRUD under Tutor Management

//SERVICE LAYER - Manages availability slots (add, update, delete, fetch)
// Acts as bridge between Controller and Repository
@Service
public class AvailabilityService {

    // Abstraction - Repositories are provided , no need to create objects manually
    @Autowired private AvailabilitySlotRepository slotRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private TutorSubjectRepository tutorSubjectRepository;
    @Autowired private SubjectRepository subjectRepository;

    //Get tutor using user ID - check if user is  Tutor
    public Tutor getTutorByUserId(int userId) {

        Optional<User> userOpt = userRepository.findById(userId);

        //Inheritance , polymorphism
        if (userOpt.isPresent() && userOpt.get() instanceof Tutor) {
            return (Tutor) userOpt.get(); //type casting
        }
        return null;
    }
    // Get all availability slots for a tutor  - Display tutor schedule
    public List<AvailabilitySlot> getSlotsForTutor(int tutorId) {

        List<AvailabilitySlot> slots = slotRepository.findByTutorIdOrderByDayAsc(tutorId);

        //load subject names for display purpose
        loadSubjectNamesForSlots(slots);
        return slots;
    }

    //Get single slot by ID -  View one availability slot
    public AvailabilitySlot getSlot(int slotId) {
        AvailabilitySlot slot = slotRepository.findById(slotId).orElse(null);
        if (slot != null) {
            loadSubjectName(slot);
        }
        return slot;
    }
    // Add new availability slot
    public void addSlot(int tutorUserId, int tutorSubjectId, String day,
                        String startTime, String endTime, String medium) {

        //Object Creation
        Tutor tutor = getTutorByUserId(tutorUserId);

        if (tutor == null) return;
        AvailabilitySlot slot = new AvailabilitySlot(
                tutor.getTutorId(), tutorSubjectId, day, startTime, endTime, medium);

        if (slot.isValidSlot()) {
            slotRepository.save(slot);
        }
    }
    // Update existing slot - Modify availability details
    public void updateSlot(int slotId, int tutorSubjectId, String day,
                           String startTime, String endTime, String medium) {
        AvailabilitySlot slot = slotRepository.findById(slotId).orElse(null);

        //Encapsulation (using setters)
        if (slot != null) {
            slot.setTutorSubjectId(tutorSubjectId);
            slot.setDay(day);
            slot.setStartTime(startTime);
            slot.setEndTime(endTime);
            slot.setMedium(medium);
            slotRepository.save(slot);
        }
    }

    //remove availability record
    public void deleteSlot(int slotId) {
        slotRepository.deleteById(slotId);
    }

    // Load subject names for list of slots
    // Display readable subject names in UI
    private void loadSubjectNamesForSlots(List<AvailabilitySlot> slots) {
        for (AvailabilitySlot slot : slots) {
            loadSubjectName(slot);
        }
    }
    //load subject name for one slot
    // Convert subject ID → subject name
    private void loadSubjectName(AvailabilitySlot slot) {
        if (slot.getTutorSubjectId() > 0) {
            tutorSubjectRepository.findById(slot.getTutorSubjectId()).ifPresent(ts -> {
                subjectRepository.findById(ts.getSubjectId()).ifPresent(s ->
                        slot.setSubjectName(s.getName()));
            });
        }
    }
}
