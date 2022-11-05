package kodlama.io.devs.business.concretes;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kodlama.io.devs.business.abstracts.LanguageService;
import kodlama.io.devs.business.abstracts.TechnologyService;
import kodlama.io.devs.business.request.TechnologyRequest;
import kodlama.io.devs.business.response.TechnologyResponse;
import kodlama.io.devs.entities.Language;
import kodlama.io.devs.entities.Technology;
import kodlama.io.devs.error.TechnologyErrorException;
import kodlama.io.devs.repository.TechnologyRepository;

@Service
public class TechnologyManager implements TechnologyService {
	private TechnologyRepository technologyRepository;
	private LanguageService languageService;

	@Autowired
	public TechnologyManager(TechnologyRepository technologyRepository, LanguageService languageService) {
		this.technologyRepository = technologyRepository;
		this.languageService = languageService;
	}

	// ismin varligini kontrol et
	private boolean isNameExists(TechnologyRequest request) {
		return this.technologyRepository.existsByName(request.getName());
	}

	// isim geceli formatta mi kontrol et
	private boolean isValidName(String name) {
		return name.isBlank();
	}

	// veriyi Technology formundan TechnologyResponse formuna cevir
	private TechnologyResponse response(Technology technology) {
		TechnologyResponse response = new TechnologyResponse();
		response.setId(technology.getId());
		response.setName(technology.getName());
		response.setReleaseYear(technology.getReleaseYear());
		response.setLanguageName(technology.getLanguage().getName());

		return response;
	}

	// hepsini getir
	@Override
	public List<TechnologyResponse> findAll() {
		List<Technology> technologies = this.technologyRepository.findAll();
		List<TechnologyResponse> responses = new ArrayList<TechnologyResponse>();

		// Technology formundan TechnologyResponse formuna cevir
		for (Technology technology : technologies) {
			TechnologyResponse response = response(technology);
			responses.add(response);
		}

		return responses;
	}

	// id degerine gore getir
	@Override
	public TechnologyResponse findById(int id) {
		// gelen veriyi yakala yoksa hata firlat
		Technology technology = this.technologyRepository.findById(id).stream().filter(item -> item.getId() == id)
				.findAny().orElseThrow(() -> new TechnologyErrorException("Id değeri bulunamadı: " + id));

		// yakalanan veriyi Technology formundan TechnologyResponse formuna cevir
		TechnologyResponse response = response(technology);

		return response;
	}

	// veriyi kaydet
	@Override
	public TechnologyResponse save(TechnologyRequest request) {
		// isim daha onceden ekli miydi?
		if (isNameExists(request)) {
			throw new TechnologyErrorException("Bu teknoloji zaten mevcut: " + request);
		}
		// isim gecerli formatta mi?
		else if (isValidName(request.getName())) {
			throw new TechnologyErrorException("Teknoloji ismi boş geçilemez.");
		}

		// gelen veriyi TechnologyRequest formundan Technology formuna cevir
		Technology technology = new Technology();
		technology.setName(request.getName());
		technology.setReleaseYear(request.getReleaseYear());

		Language language = this.languageService.findByName(request.getLanguageName());
		technology.setLanguage(language);

		this.technologyRepository.save(technology);

		// veriyi Technology formatindan TechnologyResponse formuna cevir
		TechnologyResponse response = response(technology);
		return response;
	}

	// veriyi guncelle
	@Override
	public TechnologyResponse update(int id, TechnologyRequest request) {
		// gelen veriyi yakala yoksa hata firlat
		Technology technology = this.technologyRepository.findById(id).stream().filter(item -> item.getId() == id)
				.findAny().orElseThrow(() -> new TechnologyErrorException("Id değeri bulunamadı: " + id));

		Language language = this.languageService.findByName(request.getLanguageName());

		// isim gecerli formatta mi?
		if (isValidName(request.getName())) {
			throw new TechnologyErrorException("Teknoloji ismi boş geçilemez.");
		}

		// gelen veriyi TechnologyRequest formundan Technology formuna cevir
		technology.setName(request.getName());
		technology.setReleaseYear(request.getReleaseYear());
		technology.setLanguage(language);

		this.technologyRepository.save(technology);

		TechnologyResponse response = response(technology);

		return response;
	}

	// id degeri gore sil
	@Override
	public TechnologyResponse deleteById(int id) {
		// gelen veriyi yakala yoksa hata firlat
		Technology technology = this.technologyRepository.findById(id).stream().filter(item -> item.getId() == id)
				.findAny().orElseThrow(() -> new TechnologyErrorException("Id değeri bulunamadı: " + id));

		// veriyi Technology formundan TechnologyResponse formuna cevir
		TechnologyResponse response = response(technology);

		this.technologyRepository.deleteById(id);

		return response;
	}

}
