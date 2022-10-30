package kodlama.io.devs.dao.concretes;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import kodlama.io.devs.dao.abstracts.LanguageRepository;
import kodlama.io.devs.entities.Language;

@Repository
public class InMemoryLanguageRepository implements LanguageRepository {
	private List<Language> languages;

	public InMemoryLanguageRepository() {
		this.languages = new ArrayList<Language>();
		this.languages.add(new Language(0, "ASSEMBLY", "Düşük Seviyeli Dil", "Mikroişlemciler"));
		this.languages.add(new Language(1, "C & C++", "Orta Seviyeli Dil", "Sistem Programcılığında"));
		this.languages.add(new Language(2, "JAVA", "Yüksek Seviyeli Dil", "Bilim ve Mühendislikte"));
		this.languages.add(new Language(3, "PYTHON", "Yüksek Seviyeli Dil", "Yapay Zeka Kullanımında"));
		this.languages.add(new Language(4, " VISUAL FOXPRO W", "Yüksek Seviyeli Dil", "Veri Tabanı Programcılığında"));

	}

	@Override
	public List<Language> findAll() {
		return this.languages;
	}

	@Override
	public Language findById(int languageId) {
		return this.languages.get(languageId);
	}

	@Override
	public void save(Language language) {
		this.languages.add(language);
	}

	@Override
	public void update(int languageId, Language language) {
		Language lan = findById(languageId);

		lan.setLanguageName(language.getLanguageName());
		lan.setLanguageLevel(language.getLanguageLevel());
		lan.setUsageAreas(language.getUsageAreas());
	}

	@Override
	public void deleteById(int languageId) {
		this.languages.removeIf(language -> language.getLanguageId() == languageId);
	}

}
