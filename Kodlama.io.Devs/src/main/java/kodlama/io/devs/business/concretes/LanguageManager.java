package kodlama.io.devs.business.concretes;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kodlama.io.devs.business.abstracts.LanguageService;
import kodlama.io.devs.dao.abstracts.LanguageRepository;
import kodlama.io.devs.entities.Language;

@Service
public class LanguageManager implements LanguageService {
	private LanguageRepository languageRepository;

	@Autowired
	public LanguageManager(LanguageRepository languageRepository) {
		this.languageRepository = languageRepository;
	}

	private boolean isLanguageNameExist(Language language) {
		for (Language lan : findAll()) {
			if (lan.getLanguageName().equals(language.getLanguageName().toUpperCase())) {
				return true;
			}
		}
		return false;
	}

	private boolean isIdExist(int id) {

		for (Language language2 : findAll()) {
			if (language2.getId() == id) {
				return true;
			}
		}
		return false;
	}

	@Override
	public List<Language> findAll() {
		return this.languageRepository.findAll();
	}

	@Override
	public Language findById(int id) {
		return this.languageRepository.findById(id);
	}

	@Override
	public void save(Language language) {
		if (isIdExist(language.getId())) {
			throw new RuntimeException("Bu id değerine sahip programa dili zaten mevcut: "
					+ this.languageRepository.findById(language.getId()));
		}

		else if (isLanguageNameExist(language)) {
			throw new RuntimeException("Bu programlama dili zaten ekli: " + language.getLanguageName());
		}

		else if (language.getLanguageName().isEmpty()) {
			throw new RuntimeException("Programlama dili ismi boş geçilemez.");
		}

		this.languageRepository.save(language);
	}

	@Override
	public void update(int id, Language language) {

		if (isLanguageNameExist(language)) {
			throw new RuntimeException("Bu isim zaten mevcut: " + language.getLanguageName());
		}

		else if (language.getLanguageName().isEmpty()) {
			throw new RuntimeException("Programlama dili ismi boş geçilemez.");
		}
		this.languageRepository.update(id, language);
	}

	@Override
	public void deleteById(int id) {
		if (!isIdExist(id)) {
			throw new RuntimeException("Id değeri bulunamdı: " + id);
		}
		this.languageRepository.deleteById(id);
	}
}
