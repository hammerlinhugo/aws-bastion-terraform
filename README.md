# Déploiement d'une infrastructure AWS avec Terraform

## Présentation

Ce projet a pour objectif de reproduire avec Terraform une architecture AWS
composée d'un réseau public et d'un réseau privé.

Le déploiement est réalisé progressivement à l'aide de plusieurs modules Terraform
et de plusieurs branches Git :

- `vpc` : infrastructure réseau
- `security` : groupes de sécurité
- `ec2` : instances EC2

Chaque module est développé sur sa propre branche puis fusionné dans la branche
`master`. Les branches sont conservées après fusion afin de garder une trace des
différentes étapes du projet.

---

# Module VPC

## Objectif

Le module `vpc` construit l'infrastructure réseau nécessaire au projet.

L'architecture reprend celle du TP AWS initial :

- un VPC en `10.0.0.0/16`
- un sous-réseau public en `10.0.1.0/24`
- un sous-réseau privé en `10.0.11.0/24`
- une Internet Gateway
- une NAT Gateway associée à une Elastic IP
- une table de routage publique
- une table de routage privée

Le sous-réseau public possède un accès direct à Internet via l'Internet Gateway.

Le sous-réseau privé ne possède pas d'accès direct à Internet. Son trafic sortant
passe par la NAT Gateway placée dans le sous-réseau public.

## Architecture réseau

```text
                         Internet
                            |
                            |
                     Internet Gateway
                            |
                            |
                  +---------+---------+
                  |                   |
                  |    Subnet public  |
                  |    10.0.1.0/24    |
                  |                   |
                  |    NAT Gateway    |
                  |         |         |
                  +---------|---------+
                            |
                            |
                  +---------v---------+
                  |                   |
                  |    Subnet privé   |
                  |    10.0.11.0/24   |
                  |                   |
                  +-------------------+
```
VPC : 10.0.0.0/16
Région : eu-west-2 (sélectionné à la main afin d'éviter les quotas)
AZ : eu-west-2a

# Module Security

## Objectif

Le module `security` configure les groupes de sécurité nécessaires à l'accès aux
instances EC2.

Deux groupes de sécurité sont créés :

- `tp-10-sg-bastion`
- `tp-10-sg-prive`

L'objectif est de limiter l'accès SSH au strict nécessaire.

Le bastion n'accepte les connexions SSH que depuis l'adresse IPv4 publique du
poste d'administration.

L'instance privée n'accepte les connexions SSH que depuis les machines utilisant
le groupe de sécurité du bastion.

Aucune règle SSH n'autorise la plage `0.0.0.0/0`.

---

## Architecture de sécurité

```text
Poste administrateur
IP publique /32
       |
       | TCP/22
       v
+---------------------+
| tp-10-sg-bastion    |
+---------------------+
       |
       | TCP/22
       | source = SG bastion
       v
+---------------------+
| tp-10-sg-prive      |
+---------------------+
```

# Module EC2

## Objectif

Le module `ec2` déploie les deux instances nécessaires à l'architecture :

- `tp-10-bastion`
- `tp-10-app`

Le bastion est placé dans le sous-réseau public et possède une adresse IPv4 publique.

L'instance applicative est placée dans le sous-réseau privé et ne possède aucune adresse IPv4 publique.

L'accès à l'instance privée se fait donc obligatoirement en passant par le bastion.

---

## Architecture

```text
Poste administrateur
        |
        | SSH TCP/22
        v
+-----------------------+
| tp-10-bastion         |
| Subnet public         |
| IPv4 publique         |
| SG : tp-10-sg-bastion |
+-----------------------+
        |
        | SSH TCP/22
        v
+-----------------------+
| tp-10-app             |
| Subnet privé          |
| Pas d'IPv4 publique   |
| SG : tp-10-sg-prive   |
+-----------------------+
        |
        | Trafic sortant
        v
    NAT Gateway
        |
        v
     Internet
```