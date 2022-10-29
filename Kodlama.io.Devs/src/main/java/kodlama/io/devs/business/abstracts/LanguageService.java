package kodlama.io.devs.business.abstracts;

import java.util.List;

import kodlama.io.devs.entities.Language;

public interface LanguageService {
	public List<Language> findAll();

	public Language findById(int id);

	public void save(Language language);

	public void update(int id, Language language);

	public void deleteById(int id);
}
