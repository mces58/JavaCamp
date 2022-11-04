package kodlama.io.devs.business.conretes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kodlama.io.devs.business.abstracts.LanguageService;
import kodlama.io.devs.business.request.LanguageRequest;
import kodlama.io.devs.business.response.LanguageResponse;
import kodlama.io.devs.entities.Language;
import kodlama.io.devs.repository.LanguageRepository;

@Service
public class LanguageManager implements LanguageService {
	private LanguageRepository languageRepository;

	@Autowired
	public LanguageManager(LanguageRepository languageRepository) {
		this.languageRepository = languageRepository;
	}

	@Override
	public List<LanguageResponse> findAll() {
		List<Language> languages = this.languageRepository.findAll();
		List<LanguageResponse> responses = new ArrayList<LanguageResponse>();

		for (Language language : languages) {
			LanguageResponse response = new LanguageResponse();
			response.setLanguageName(language.getLanguageName());
			response.setLevel(language.getLevel());

			responses.add(response);
		}

		return responses;
	}

	@Override
	public LanguageResponse findAllById(int id) {
		Optional<Language> result = this.languageRepository.findById(id);
		Language language = null;

		if (result.isPresent()) {
			language = result.get();
		} else {
			throw new RuntimeException("id degeri bulunamadi");
		}

		LanguageResponse response = new LanguageResponse();
		response.setLanguageName(language.getLanguageName());
		response.setLevel(language.getLevel());

		return response;
	}

	@Override
	public void save(LanguageRequest languageRequest) {

		Language language = new Language();
		language.setLanguageName(languageRequest.getLanguageName());
		language.setLevel(languageRequest.getLevel());

		this.languageRepository.save(language);
	}

	@Override
	public void update(int id, LanguageRequest languageRequest) {

		Object language = this.languageRepository.findById(id);
		Language lan = (Language) language;

		lan.setLanguageName(languageRequest.getLanguageName());
		lan.setLevel(languageRequest.getLevel());

		this.languageRepository.save((Language) lan);
	}

	@Override
	public void deleteById(int id) {
		this.languageRepository.deleteById(id);
	}

}
