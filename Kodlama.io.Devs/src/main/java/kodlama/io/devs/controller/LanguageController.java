package kodlama.io.devs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kodlama.io.devs.business.abstracts.LanguageService;
import kodlama.io.devs.entities.Language;
import kodlama.io.devs.error.LanguageNotFoundException;

@RestController
@RequestMapping(value = "/webApi")
public class LanguageController {
	private LanguageService service;

	@Autowired
	public LanguageController(LanguageService service) {
		this.service = service;
	}

	@GetMapping(value = "/languages")
	public List<Language> findAll() {
		return this.service.findAll();
	}

	@GetMapping(value = "/languages/{id}")
	public Language findById(@PathVariable int id) {
		if (id >= this.service.findAll().size() || id < 0) {
			throw new LanguageNotFoundException("Bu id değerine sahip programlama dili yok: " + id);
		}
		return this.service.findById(id);
	}

	@PostMapping(value = "/languages")
	public String save(@RequestBody Language language) {

		String name = language.getLanguageName().toUpperCase();
		language.setLanguageName(name);

		this.service.save(language);

		return "Kayıt Eklendi.";
	}

	@PutMapping(value = "/languages/{id}")
	public String update(@PathVariable int id, @RequestBody Language language) {
		if (id >= this.service.findAll().size() || id < 0) {
			throw new LanguageNotFoundException("Bu id degerine sahip progralama dili yok: " + id);
		}
		String name = language.getLanguageName().toUpperCase();
		language.setLanguageName(name);

		this.service.update(id, language);
		return "Kayıt Güncellendi.";
	}

	@DeleteMapping(value = "/languages/{id}")
	public String deleteById(@PathVariable int id) {
		this.service.deleteById(id);
		return "Kayıt silindi.";
	}
}
