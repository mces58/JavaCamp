package kodlama.io.devs.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kodlama.io.devs.entities.Technology;

public interface TechnologyRepository extends JpaRepository<Technology, Integer> {

	// isim var mi
	boolean existsByName(String name);
}
