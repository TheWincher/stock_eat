# TODO

## Cassé
- [x] Corriger `test/widget_test.dart` (hangait à cause d'un Timer interne de nettoyage de Drift toujours en attente au moment du teardown du binding de test)

## CRUD incomplet
- [x] Suppression de `Category` (use case + UI, bloquée si un produit référence encore la catégorie via `ON DELETE RESTRICT`)
- [ ] Suppression de `Product` (use case + UI)
- [ ] Modification de quantité pour `StockItem` (use case + UI, `StockRepository.update` existe déjà côté infra)

## UX
- [ ] Indicateur visuel pour les DLC proches/dépassées dans `StockListPage`
- [ ] Confirmation avant suppression (actuellement le swipe supprime directement, sans annuler)
- [ ] Validation/retour d'erreur dans les formulaires (ex: quantité invalide échoue silencieusement)

## Tests
- [ ] Écrire de vrais tests unitaires/widget (au-delà du test par défaut du template)

## Hors scope MVP (volontaire, cf. CLAUDE.md)
- Unités et emplacements configurables par l'utilisateur
- Historique des mouvements de stock
- Distinction DLC/DDM

## Jamais abordé
- Scan de code-barres (champ `barcode` existe sur `Product`, inutilisé)
- Thème/UI (toujours le `MaterialApp` par défaut)
