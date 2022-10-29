package kodlama.io.devs.dao.abstracts;

import java.util.List;

import kodlama.io.devs.entities.Language;

public interface LanguageRepository {
	public List<Language> findAll();

	public Language findById(int id);

	public void save(Language language);

	public void update(int id, Language language);

	public void deleteById(int id);
}
