#!/bin/bash

# Ce script va permettre de créer automatiquement un nombre souhaité d'utilisateurs, passés en argument.

# On commence par récupérer la liste des utilisateurs passés en argument
users=$@

# Si la liste d'utilisateurs passée en argument est vide, on arrête le script
if [ -z "$users" ]
then
    echo "Il manque les noms d'utilisateurs en argument - Fin du script"
    exit 1
fi

# Si la liste n'est pas vide, on va pouvoir la parcourir pour traiter la création des utilisateurs
for user in $users
do
    # On commence par vérifier l'existence de l'utilisateur
    if id "$user" > /dev/null 2>&1
    then
        # S'il existe on prévient l'administrateur
        echo "L'utilisateur $user existe déjà"
    else
        # S'il n'existe pas, on va pouvoir continuer et créer l'utilisateur
        sudo useradd $user
        # On vérifie que cet utilisateur a bien été créé
        if id "$user" > /dev/null 2>&1
        then
            # Il a bien été créé, on peut confirmer la création.
            echo "L'utilisateur $user a été créé"
        else
            # Il n'a pas été créé, on annonce l'erreur
            echo "Erreur à la création de l'utilisateur $user"
        fi
    fi
done