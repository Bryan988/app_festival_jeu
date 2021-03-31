# Application Mobile Festival des jeux de Montpellier

## Description 

Cette application permet de récupèrer des données et de les afficher grâce à une API externe. 
Cette API permet de gérer le festival des jeux qui se déroule à Montpellier annuellement.  
Lien API correspondante : https://github.com/LeoMld/festival_jeu

Cette application mobile permet donc de visualiser les données du festival courant.  
On peut nottement y voir : 
* La liste des jeux
* Les Zones
  * Les jeux par zone
* Les Editeurs
  * Les jeux par éditeur
  
## Installation 

``` 
git clone https://github.com/Bryan988/app_festival_jeu.git
```

## Architecture 

![image](https://user-images.githubusercontent.com/55983043/113162475-9ed0a180-923f-11eb-8602-19d5f942ba04.png)

Cette application est basée sur la pattern MVI, ci-dessous un exemple lors de l'affichage des jeux du festival courant :

![image](https://user-images.githubusercontent.com/55983043/113166108-c07f5800-9242-11eb-8b7f-ee3cff1640ae.png)

