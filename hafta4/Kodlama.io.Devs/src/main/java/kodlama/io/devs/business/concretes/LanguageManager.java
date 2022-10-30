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

	// id numarasinin var olmasini kontrol et
	private boolean isIdExist(int languageId) {
		for (Language language : findAll()) {
			if (language.getLanguageId() == languageId) {
				return true;
			}
		}
		return false;
	}

	// isim degerinin var olmasini kontrol et
	private boolean isNameExist(Language language) {
		for (Language lan : findAll()) {
			if (lan.getLanguageName().equals(language.getLanguageName())) {
				return true;
			}
		}
		return false;
	}

	// tum verileri getir
	@Override
	public List<Language> findAll() {
		return this.languageRepository.findAll();
	}

	// id numarasina getir
	@Override
	public Language findById(int languageId) {
		// id degeri yok ise hata firlat
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

	// programlama dili kaydet
	@Override
	public void save(Language language) {
		// gelen verinin ismini upper case yap
		language.setLanguageName(language.getLanguageName().toUpperCase());

		// id numarasi daha onceden var ise hata firlat
		if (isIdExist(language.getLanguageId())) {
			throw new RuntimeException("Bu id değerine sahip programlama dili zaten mevcut: "
					+ this.languageRepository.findById(language.getLanguageId()));
		}

		// isim daha onceden var ise hata firlat
		else if (isNameExist(language)) {
			throw new RuntimeException("Bu programlama dili zaten mevcut: " + language.getLanguageName());
		}

		// isim degeri boş ise hata firlat
		else if (language.getLanguageName().isEmpty()) {
			throw new RuntimeException("Programlama dili ismi boş geçilemez.");
		}

		this.languageRepository.save(language);
	}

	// programlama dilini guncelle
	@Override
	public void update(int languageId, Language language) {
		// gelen verinin ismini upper case yap
		language.setLanguageName(language.getLanguageName().toUpperCase());

		// guncellenmek istenen verinin id degeri yok ise hata firlat
		if (!isIdExist(languageId)) {
			throw new LanguageNotFoundException("Bu id değeri bulunamadı: " + languageId);
		}

		// daha onceden ekli isim var ise hata firlat
		else if (isNameExist(language)) {
			throw new RuntimeException("Bu isim zaten mevcut: " + language.getLanguageName());
		}

		// isim bos olarak guncellemek isterse hata firlat
		else if (language.getLanguageName().isEmpty()) {
			throw new RuntimeException("Programlama dili ismi boş geçilemez.");
		}

		this.languageRepository.update(languageId, language);
	}

	// id numarasina gore sil
	@Override
	public void deleteById(int languageId) {
		// silinmek istenen veri yok ise hata firlat
		if (!isIdExist(languageId)) {
			throw new LanguageNotFoundException("Bu id değeri bulunamadı: " + languageId);
		}

		this.languageRepository.deleteById(languageId);
	}

}
