Feature: Ejercicio 2 Testing webservices

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: Añadir mascota
    * def pet =
      """
      {
          "id": 4,
          "category": {
            "id": 4,
            "name": "Dogs"
          },
          "name": "Dog",
          "photoUrls": [
            "https://cdn.pixabay.com/photo/2020/06/08/22/50/dog-5276317_960_720.png"
          ],
          "tags": [
            {
              "id": 4,
              "name": "RazaDelPerro"
            }
          ],
          "status": "available"
        }
      """

    Given url 'https://petstore.swagger.io/'
    Given path '/v2/pet'
    And request pet
    When method post
    Then status 200

    * def id = response.id
    * def name = response.name
    * print 'El ID de la mascota creada es: ', id, 'El nombre de la mascota creada es: ', name
    And match response.*.* ==
    """
    [4,"Dogs","https:\/\/cdn.pixabay.com\/photo\/2020\/06\/08\/22\/50\/dog-5276317_960_720.png",{"id":4,"name":"RazaDelPerro"}]
    """

  Scenario: Obtener Mascota Existente
    Given url 'https://petstore.swagger.io/'
    Given path '/v2/pet/4'
    When method get
    Then status 200
    And match response.*.* ==
    """
    [4,"Dogs","https:\/\/cdn.pixabay.com\/photo\/2020\/06\/08\/22\/50\/dog-5276317_960_720.png",{"id":4,"name":"RazaDelPerro"}]
    """
    * def id = response.id
    * def name = response.name
    * print 'El ID de la mascota es: ', id
    * print 'El nombre de la mascota es: ', name

  Scenario: Modificar Mascota Existente
    * def pet2 =
      """
        {
          "id": 4,
          "category": {
            "id": 4,
            "name": "Perro"
          },
          "name": "Ovejero Aleman",
          "photoUrls": [
            "https://t2.ea.ltmcdn.com/es/images/7/0/0/alimentacion_de_un_pastor_aleman_cachorro_21007_orig.jpg"
          ],
          "tags": [
            {
              "id": 4,
              "name": "Ovejero"
            }
          ],
          "status": "available"
        }
      """
    Given url 'https://petstore.swagger.io/'
    Given path '/v2/pet'
    And request pet2
    When method put
    Then status 200

    * def id = response.id
    * def name = response.name
    * print 'El ID de la mascota es: ', id
    * print 'El nombre de la mascota ahora es: ', name
    And match response.*.* ==
    """
    [4,"Perro","https://t2.ea.ltmcdn.com/es/images/7/0/0/alimentacion_de_un_pastor_aleman_cachorro_21007_orig.jpg",{"id":4,"name":"Ovejero"}]
    """


  