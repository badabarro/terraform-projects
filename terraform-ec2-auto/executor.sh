#!/bin/bash

ERROR_LOG="terraform-errors.txt"

rm -f $ERROR_LOG

echo "[1/4] Initialisation de Terraform..."
terraform init > /dev/null 2>> $ERROR_LOG
if [ $? -ne 0 ]; then
    echo "Erreur lors de l'initialisation. Voir $ERROR_LOG"
    exit 1
fi
echo "Initialisation réussie."

echo "[2/4] Validation de la configuration..."
terraform validate > /dev/null 2>> $ERROR_LOG
if [ $? -ne 0 ]; then
    echo "Erreur de validation. Voir $ERROR_LOG"
    exit 1
fi
echo "Validation réussie."

echo "[3/4] Génération du plan Terraform..."
terraform plan > /dev/null 2>> $ERROR_LOG
if [ $? -ne 0 ]; then
    echo "Erreur lors du plan Terraform. Voir $ERROR_LOG"
    exit 1
fi
echo "Plan généré avec succès."

echo "[4/4] Application du plan..."
terraform apply -auto-approve > /dev/null 2>> "${ERROR_LOG}"
if [ $? -ne 0 ]; then
    echo "Erreur lors de l'application du plan. Voir $ERROR_LOG"
    exit 1
fi
echo "Infrastructure déployée avec succès."

#Note: Executer terraform destroy pour nettoyer l'infrastructure après les tests.