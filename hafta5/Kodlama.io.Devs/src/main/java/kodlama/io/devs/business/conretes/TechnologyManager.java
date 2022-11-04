package kodlama.io.devs.business.conretes;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kodlama.io.devs.business.abstracts.LanguageService;
import kodlama.io.devs.business.abstracts.TechnologyService;
import kodlama.io.devs.business.request.TechnologyRequest;
import kodlama.io.devs.business.response.LanguageResponse;
import kodlama.io.devs.business.response.TechnologyResponse;
import kodlama.io.devs.entities.Language;
import kodlama.io.devs.entities.LanguageTechnology;
import kodlama.io.devs.repository.LanguageTechnologyRepository;

@Service
public class TechnologyManager implements TechnologyService {
	private LanguageTechnologyRepository technologyRepository;
	private LanguageService languageService;

	@Autowired
	public TechnologyManager(LanguageTechnologyRepository technologyRepository, LanguageService languageService) {
		this.technologyRepository = technologyRepository;
		this.languageService = languageService;
	}

	@Override
	public List<TechnologyResponse> findAll() {
		List<LanguageTechnology> technologies = this.technologyRepository.findAll();
		List<TechnologyResponse> responses = new ArrayList<>();

		for (LanguageTechnology technology : technologies) {
			TechnologyResponse response = new TechnologyResponse();
			response.setTechnologyName(technology.getTechnologyName());
			response.setLanguageId(technology.getLanguage().getLanguageId());
			response.setTechnologyId(technology.getId());

			responses.add(response);
		}
		return responses;
	}

	@Override
	public TechnologyResponse findAllById(int id) {

		return null;
	}

	@Override
	public void save(TechnologyRequest technologyRequest) {
		LanguageTechnology technology = new LanguageTechnology();
		LanguageResponse language = this.languageService.findAllById(technologyRequest.getLanguageId());

		Language language2 = new Language();
		language2.setLanguageName(language.getLanguageName());
		language2.setLevel(language.getLevel());

		technology.setTechnologyName(technologyRequest.getTechnologyName());
		technology.setLanguage(language2);

		this.technologyRepository.save(technology);
	}

	@Override
	public void update(int id, TechnologyRequest technologyRequest) {
		Object obj = this.technologyRepository.findById(id);
		LanguageTechnology update = (LanguageTechnology) obj;

		LanguageResponse language = this.languageService.findAllById(technologyRequest.getLanguageId());

		Language language2 = new Language();
		language2.setLanguageName(language.getLanguageName());
		language2.setLevel(language.getLevel());

		update.setTechnologyName(technologyRequest.getTechnologyName());
		update.setLanguage(language2);

		this.technologyRepository.save(update);
	}

	@Override
	public void delete(int id) {
		this.technologyRepository.deleteById(id);

	}

}
