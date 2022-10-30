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

@RestController
@RequestMapping(value = "/rest")
public class LanguageController {
	private LanguageService languageService;

	@Autowired
	public LanguageController(LanguageService languageService) {
		this.languageService = languageService;
	}

	// hepsini getir
	@GetMapping(value = "/languages")
	public List<Language> findAll() {
		return this.languageService.findAll();
	}

	// id numarasina gore getir
	@GetMapping(value = "/languages/{languageId}")
	public Language findById(@PathVariable int languageId) {
		return this.languageService.findById(languageId);
	}

	// gelen veriyi kaydet
	@PostMapping(value = "/languages")
	public String save(@RequestBody Language language) {
		this.languageService.save(language);

		return "Kayıt Eklendi.";
	}

	// gelen veriyi guncelle
	@PutMapping(value = "/languages/{languageId}")
	public String update(@PathVariable int languageId, @RequestBody Language language) {
		this.languageService.update(languageId, language);

		return "Kayıt Güncellendi.";
	}

	// id numarasina gore sil
	@DeleteMapping(value = "/languages/{languageId}")
	public String deleteById(@PathVariable int languageId) {
		this.languageService.deleteById(languageId);

		return "Kayıt Silindi.";
	}
}
