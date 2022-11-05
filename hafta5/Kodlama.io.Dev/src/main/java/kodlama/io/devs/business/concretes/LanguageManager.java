package kodlama.io.devs.business.concretes;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kodlama.io.devs.business.abstracts.LanguageService;
import kodlama.io.devs.business.request.LanguageRequest;
import kodlama.io.devs.business.response.LanguageResponse;
import kodlama.io.devs.entities.Language;
import kodlama.io.devs.error.LanguageErrorException;
import kodlama.io.devs.repository.LanguageRepository;

@Service
public class LanguageManager implements LanguageService {
	private LanguageRepository languageRepository;

	@Autowired
	public LanguageManager(LanguageRepository languageRepository) {
		this.languageRepository = languageRepository;
	}

	// ismin varligini kontrol et
	private boolean isNameExists(LanguageRequest request) {
		return this.languageRepository.existsByName(request.getName());
	}

	// isim gecerli formatta mi kontrol et
	private boolean isValidName(String name) {
		return name.isBlank();
	}

	// veriyi Language formundan LanguageResponse formuna cevir
	private LanguageResponse response(Language language) {
		LanguageResponse response = new LanguageResponse();
		response.setId(language.getId());
		response.setName(language.getName());
		response.setLevel(language.getLevel());

		return response;
	}

	// veriyi LanguageRequest formundan Language formuna cevir
	private Language language(LanguageRequest request) {
		Language language = new Language();
		language.setName(request.getName());
		language.setLevel(request.getLevel());

		return language;
	}

	// hepsini getir
	@Override
	public List<LanguageResponse> findAll() {
		List<Language> languages = this.languageRepository.findAll();
		List<LanguageResponse> responses = new ArrayList<LanguageResponse>();

		// Language formundan LanguageResponse formuna cevir
		for (Language language : languages) {
			LanguageResponse response = response(language);
			responses.add(response);
		}

		return responses;
	}

	// id degerine gore getir
	@Override
	public LanguageResponse findById(int id) {
		// gelen veriyi ara yoksa hata firlat
		Language language = this.languageRepository.findById(id).stream().filter(item -> item.getId() == id).findAny()
				.orElseThrow(() -> new LanguageErrorException("Id değeri bulunamadı: " + id));

		// yakalanan veriyi Language formundan LanguageResponse formuna cevir
		LanguageResponse response = response(language);

		return response;
	}

	// veriyi kaydet
	@Override
	public LanguageResponse save(LanguageRequest request) {
		// isim daha onceden ekli miydi?
		if (isNameExists(request)) {
			throw new LanguageErrorException("Bu programlama dili zaten mevcut: " + request);
		}
		// isim gecerli formatta mi?
		else if (isValidName(request.getName())) {
			throw new LanguageErrorException("Programlama dili ismi boş geçilemez.");
		}

		// gelen veriyi LanguageRequest formundan Language formuna cevir
		Language language = language(request);

		this.languageRepository.save(language);

		// veriyi Language formundan LanguageResponse formuna cevir
		LanguageResponse response = response(language);

		return response;
	}

	// veriyi guncelle
	@Override
	public LanguageResponse update(int id, LanguageRequest request) {
		// gelen veriyi ara yoksa hata firlat
		Language language = this.languageRepository.findById(id).stream().filter(item -> item.getId() == id).findAny()
				.orElseThrow(() -> new LanguageErrorException("Id değeri bulunamadı: " + id));

		// isim daha onceden ekli miydi?
		if (isNameExists(request)) {
			throw new LanguageErrorException("Bu programlama dili zaten mevcut: " + request);
		}
		// isim gecerli formatta mi?
		else if (isValidName(request.getName())) {
			throw new LanguageErrorException("Programlama dili ismi boş geçilemez.");
		}

		// gelen veriyi LanguageRequest formundan Language formuna cevir
		language.setName(request.getName());
		language.setLevel(request.getLevel());

		this.languageRepository.save(language);

		// veriyi Language formundan LanguageResponse formuna cevir
		LanguageResponse response = response(language);

		return response;
	}

	// id degerine gore sil
	@Override
	public LanguageResponse deleteById(int id) {
		// gelen veriyi ara yoksa hata firlat
		Language language = this.languageRepository.findById(id).stream().filter(item -> item.getId() == id).findAny()
				.orElseThrow(() -> new LanguageErrorException("Id değeri bulunamadı: " + id));

		// veriyi Language formundan LanguageResponse formuna cevir
		LanguageResponse response = response(language);

		this.languageRepository.deleteById(id);

		return response;
	}

	// isme gore arama
	@Override
	public Language findByName(String languageName) {
		return this.languageRepository.findByName(languageName);
	}

}
