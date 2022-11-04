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
import kodlama.io.devs.business.request.LanguageRequest;
import kodlama.io.devs.business.response.LanguageResponse;

@RestController
@RequestMapping(value = "/api/languages")
public class LanguageController {
	private LanguageService service;

	@Autowired
	public LanguageController(LanguageService service) {
		this.service = service;
	}

	@GetMapping(value = "/")
	public List<LanguageResponse> findAll() {
		return this.service.findAll();
	}

	@GetMapping(value = "/{id}")
	public LanguageResponse language(@PathVariable int id) {
		return this.service.findAllById(id);
	}

	@PostMapping(value = "/")
	public String save(@RequestBody LanguageRequest languageRequest) {
		this.service.save(languageRequest);

		return "Kayit Eklendi.";
	}

	@PutMapping(value = "/{id}")
	public String update(@RequestBody LanguageRequest languageRequest, @PathVariable int id) {
		this.service.update(id, languageRequest);

		return "Kayit Guncellendi";
	}

	@DeleteMapping(value = "/{id}")
	public String deleteById(@PathVariable int id) {
		this.service.deleteById(id);

		return "Kayit silindi.";
	}
}
