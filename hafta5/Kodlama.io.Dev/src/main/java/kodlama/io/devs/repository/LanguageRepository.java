package kodlama.io.devs.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kodlama.io.devs.entities.Language;

public interface LanguageRepository extends JpaRepository<Language, Integer> {

	// isme gore getirme
	Language findByName(String languageName);

	// isim var mi
	boolean existsByName(String name);

}
