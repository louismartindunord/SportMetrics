from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import os
import sys

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "../utils")))
from data_extraction import create_connection


service = Service()
options = webdriver.ChromeOptions()
driver = webdriver.Chrome(service=service, options=options)


def get_cross_training_exercises():
    driver.get(
        "https://www.toutelanutrition.com/wikifit/entrainement/exercices-materiel/crossfit-a-la-maison-les-meilleurs-exercices"
    )
    cross_training_exercises = driver.find_elements(By.TAG_NAME, "h3")
    exercises_text = [exercise.text for exercise in cross_training_exercises]
    print(exercises_text)
    driver.quit()
    return exercises_text


def insert_cross_training_exercises():
    cross_training_exercises = get_cross_training_exercises()
    connection = create_connection()
    cursor = connection.cursor()

    for exercise in cross_training_exercises:
        if len(exercise) > 3:
            sql = """INSERT INTO cross_training_exercises(name)
                     VALUES (%s)
                     ON CONFLICT DO NOTHING"""
            cursor.execute(sql, (exercise,))

    connection.commit()
    cursor.close()
    connection.close()


if __name__ == "__main__":
    insert_cross_training_exercises()
