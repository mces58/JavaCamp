package kodlama.io.devs.business.concretes;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kodlama.io.devs.business.abstracts.LanguageService;
import kodlama.io.devs.dao.abstracts.LanguageRepository;
import kodlama.io.devs.entities.Language;
import kodlama.io.devs.error.LanguageNotFoundException;

@Service
public class LanguageManager implements LanguageService {
	private LanguageRepository languageRepository;

	@Autowired
	public LanguageManager(LanguageRepository languageRepository) {
		this.languageRepository = languageRepository;
	}

	private boolean isIdExist(int languageId) {
		for (Language language : findAll()) {
			if (language.getLanguageId() == languageId) {
				return true;
			}
		}
		return false;
	}

	private boolean isNameExist(Language language) {
		for (Language lan : findAll()) {
			if (lan.getLanguageName().equals(language.getLanguageName())) {
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
	public Language findById(int languageId) {
		if (!isIdExist(languageId)) {
			throw new LanguageNotFoundException("Bu id değeri bulunamadı: " + languageId);
		}

		List<Language> languages = findAll();
		for (Language language : languages) {
			if (language.getLanguageId() == languageId) {
				return language;
			}
		}
		return null;
	}

	@Override
	public void save(Language language) {
		language.setLanguageName(language.getLanguageName().toUpperCase());

		if (isIdExist(language.getLanguageId())) {
			throw new RuntimeException("Bu id değerine sahip programlama dili zaten mevcut: "
					+ this.languageRepository.findById(language.getLanguageId()));
		}

		else if (isNameExist(language)) {
			throw new RuntimeException("Bu programlama dili zaten mevcut: " + language.getLanguageName());
		}

		else if (language.getLanguageName().isEmpty()) {
			throw new RuntimeException("Programlama dili ismi boş geçilemez.");
		}

		this.languageRepository.save(language);
	}

	@Override
	public void update(int languageId, Language language) {
		language.setLanguageName(language.getLanguageName().toUpperCase());

		if (!isIdExist(languageId)) {
			throw new LanguageNotFoundException("Bu id değeri bulunamadı: " + languageId);
		}

		else if (isNameExist(language)) {
			throw new RuntimeException("Bu isim zaten mevcut: " + language.getLanguageName());
		}

		else if (language.getLanguageName().isEmpty()) {
			throw new RuntimeException("Programlama dili ismi boş geçilemez.");
		}

		this.languageRepository.update(languageId, language);
	}

	@Override
	public void deleteById(int languageId) {
		if (!isIdExist(languageId)) {
			throw new LanguageNotFoundException("Bu id değeri bulunamadı: " + languageId);
		}

		this.languageRepository.deleteById(languageId);
	}

}
