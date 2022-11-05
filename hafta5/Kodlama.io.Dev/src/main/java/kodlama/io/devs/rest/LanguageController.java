package kodlama.io.devs.rest;

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
@RequestMapping(value = "/api")
public class LanguageController {
	private LanguageService service;

	@Autowired
	public LanguageController(LanguageService service) {
		this.service = service;
	}

	@GetMapping(value = "/languages")
	public List<LanguageResponse> findAll() {
		return this.service.findAll();
	}

	@GetMapping(value = "/languages/{id}")
	public LanguageResponse findById(@PathVariable int id) {
		return this.service.findById(id);
	}

	@PostMapping(value = "/languages")
	public LanguageResponse save(@RequestBody LanguageRequest request) {
		return this.service.save(request);
	}

	@PutMapping(value = "/languages/{id}")
	public LanguageResponse update(@PathVariable int id, @RequestBody LanguageRequest request) {
		return this.service.update(id, request);
	}

	@DeleteMapping(value = "/languages/{id}")
	public LanguageResponse deleteById(@PathVariable int id) {
		return this.service.deleteById(id);
	}

}
