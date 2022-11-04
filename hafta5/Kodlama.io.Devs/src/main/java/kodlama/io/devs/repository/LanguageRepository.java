package kodlama.io.devs.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kodlama.io.devs.entities.Language;

public interface LanguageRepository extends JpaRepository<Language, Integer> {
}
