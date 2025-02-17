package com.example.telemedicineapp;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

class HomeScreenTest extends BaseTest {

	@Test
	public void testDoctorsListAndDoctorData() {
		System.out.println("------ Testing Doctors List and Doctor Data ------");

		login("harishks2502@gmail.com", "admin@2502");

		WebElement recyclerView = wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/doctorsListRecyclerView")));

		List<WebElement> doctorsNameList = recyclerView
				.findElements(By.id("com.example.telemedicineapp:id/doctorName"));
		if (doctorsNameList.size() > 2) {
			System.out.println("Doctor Name: " + doctorsNameList.get(2).getText());
		} else {
			System.out.println("Less than 3 doctors available in the list");
			return;
		}

		List<WebElement> doctorsDetailIcon = recyclerView
				.findElements(By.id("com.example.telemedicineapp:id/viewDetailsIcon"));
		if (doctorsDetailIcon.size() > 2) {
			doctorsDetailIcon.get(2).click();
		} else {
			System.out.println("Less than 3 doctors available for details view");
			return;
		}

		try {
			WebElement doctorName = wait.until(
					ExpectedConditions.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/doctorName")));
			assertEquals("Dr. Naveen Kumar", doctorName.getText());
			System.out.println("Doctor Details Verified: " + doctorName.getText());
		} catch (Exception e) {
			System.out.println("Doctor details screen did not appear.");
			fail("Doctor details screen did not appear.");
		}
	}

	@Test
	public void testDoctorSearchFunctionality() {
		System.out.println("------ Testing Doctor Search Functionality ------");

		login("harishks2502@gmail.com", "admin@2502");

		WebElement searchView = wait.until(
				ExpectedConditions.elementToBeClickable(By.id("com.example.telemedicineapp:id/doctorSearchView")));
		searchView.click();
		searchView.clear();
		searchView.sendKeys("Dr. Naveen Kumar");

		WebElement recyclerView = wait.until(ExpectedConditions
				.visibilityOfElementLocated(By.id("com.example.telemedicineapp:id/doctorsListRecyclerView")));

		List<WebElement> doctorsList = recyclerView.findElements(By.id("com.example.telemedicineapp:id/doctorName"));

		assertFalse(doctorsList.isEmpty(), "No doctors found after search!");

		String displayedDoctor = doctorsList.get(0).getText();
		assertTrue(displayedDoctor.contains("Dr. Naveen Kumar"), "Searched doctor not found in the results!");

		System.out.println("Doctor Found: " + displayedDoctor);

	}

}
