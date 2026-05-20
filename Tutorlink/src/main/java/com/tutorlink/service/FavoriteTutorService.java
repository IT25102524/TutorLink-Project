package com.tutorlink.service;
import com.tutorlink.model.FavoriteTutor;
import com.tutorlink.model.Tutor;
import com.tutorlink.repository.FavoriteTutorRepository;
import com.tutorlink.repository.TutorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;

// FavoriteTutor service - handles favorite tutor logic
@Service
public class FavoriteTutorService {
    @Autowired private FavoriteTutorRepository favoriteRepository;
    @Autowired private TutorRepository tutorRepository;

    // Toggle favorite - add if not exists, remove if exists
    @Transactional
    public boolean toggleFavorite(int studentId, int tutorId) {
        java.util.Optional<FavoriteTutor> existing = favoriteRepository.findByStudentIdAndTutorId(studentId, tutorId);
        if (existing.isPresent()) {
            favoriteRepository.deleteByStudentIdAndTutorId(studentId, tutorId);
            return false; // removed from favorites
        } else {
            FavoriteTutor fav = new FavoriteTutor(studentId, tutorId);
            favoriteRepository.save(fav);
            return true; // added to favorites
        }
    }

    // Check if student has favorited a tutor
    public boolean isFavorited(int studentId, int tutorId) {
        return favoriteRepository.findByStudentIdAndTutorId(studentId, tutorId).isPresent();
    }

    // Get all favorites for a student with tutor details
    public List<FavoriteTutor> getFavorites(int studentId) {
        List<FavoriteTutor> favorites = favoriteRepository.findByStudentIdOrderByFavoriteIdDesc(studentId);
        List<FavoriteTutor> enriched = new ArrayList<>();
        for (FavoriteTutor fav : favorites) {
            tutorRepository.findById(fav.getTutorId()).ifPresent(tutor -> {
                fav.setTutorName(tutor.getFullName());
                fav.setTutorSubject(tutor.getSubject());
                fav.setTutorDistrict(tutor.getDistrict());
                fav.setTutorOnlineRate(tutor.getEffectiveOnlineRate());
                fav.setTutorHomeVisitRate(tutor.getEffectiveHomeVisitRate());
                fav.setTutorExperience(tutor.getExperience());
                fav.setTutorBio(tutor.getBio());
                enriched.add(fav);
            });
        }
        return enriched;
    }

    // Get count of favorites for a student
    public int getFavoriteCount(int studentId) {
        return favoriteRepository.countByStudentId(studentId);
    }

    // Get list of favorited tutor IDs for quick lookup
    public java.util.Set<Integer> getFavoritedTutorIds(int studentId) {
        java.util.Set<Integer> ids = new java.util.HashSet<>();
        List<FavoriteTutor> favorites = favoriteRepository.findByStudentIdOrderByFavoriteIdDesc(studentId);
        for (FavoriteTutor fav : favorites) {
            ids.add(fav.getTutorId());
        }
        return ids;
    }
}
