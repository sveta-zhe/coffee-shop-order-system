# Система управления заказами для сети кофеен «Кофеин»

## О проекте
Это учебный проект для портфолио системного аналитика.  
Цель — спроектировать систему автоматизации приема заказов в кофейне, включая:

Система позволяет:
- Клиентам — делать заказы онлайн, оплачивать, получать уведомления
- Бариста — видеть очередь заказов на планшете
- Управляющим — смотреть дашборд с выручкой и отчетами

## Артефакты проекта

### Требования и анализ
- [User personas](docs/01_requirements/user_personas.md)
- [User stories (Gherkin)](docs/01_requirements/user_stories_gherkin.md)

### Диаграммы
- [BPMN процесса заказа](diagrams/bpmn/order_process.puml)
- [UML Activity diagram](diagrams/uml/activity_order.puml)
- [UML Sequence diagram](diagrams/uml/sequence_order.puml)
- [ER-диаграмма](diagrams/erd/er_diagram.puml)

### API и интеграции
- [OpenAPI спецификация](docs/02_api/api_specification.yaml)
- [Описание интеграций](docs/02_api/integrations.md)

### Архитектура
- [ADR-001: Монолит vs микросервисы](docs/04_architecture/adr-001-monolith-vs-microservices.md)
- [ADR-002: Синхронная vs асинхронная оплата](docs/04_architecture/adr-002-payment-sync-vs-async.md)
- [ADR-003: Стратегия кэширования](docs/04_architecture/adr-003-caching-strategy.md)


### Нефункциональные требования
- [NFR (нагрузка, доступность, безопасность)](docs/03_nfr/nfr.md)

### Тестирование
- [План тестирования](docs/05_testing/test_plan.md)
- [Приемочные тесты (Gherkin)](docs/05_testing/acceptance_tests.feature)
- [Тестовые данные (SQL)](sql/test_data.sql)

### Пользовательская документация
- [Руководство клиента](docs/06_user_guides/client_guide.md)
- [Руководство бариста](docs/06_user_guides/barista_guide.md)
- [Руководство управляющего](docs/06_user_guides/manager_guide.md)

## Как использовать
1. Склонируйте репозиторий
2. Откройте диаграммы в PlantUML (установите плагин в VS Code)
3. Изучайте артефакты в порядке нумерации папок

## tree /F
``` text 
README.md
│   
├───diagrams
│   ├───bpmn
│   │       order_process.png
│   │       order_process.puml
│   │       
│   ├───erd
│   │       er-diagram.png
│   │       er_diagram.puml
│   │       
│   └───uml
│           activity_order.png
│           activity_order.puml
│           sequence_order.png
│           sequence_order.puml
│           
├───docs
│   ├───01_requirements
│   │       data_dictionary.md
│   │       data_model.md
│   │       process_description.md
│   │       stakeholder_questions.md
│   │       user_personas.md
│   │       user_stories_gherkin.md
│   │       
│   ├───02_api
│   │       api_specification.yaml
│   │       integrations.md
│   │       
│   ├───03_nfr
│   │       nfr.md
│   │       
│   ├───04_architecture
│   │       adr-001-monolith-vs-microservices.md
│   │       adr-002-payment-sync-vs-async.md
│   │       adr-003-caching-strategy.md
│   │       adr-004-database-choice.md
│   │       adr-005-language-choice.md
│   │       
│   ├───05_testing
│   │       acceptance_tests.feature
│   │       bug_example.md
│   │       bug_report_template.md
│   │       checklist.md
│   │       test_data_guide.md
│   │       test_plan.md
│   │       
│   ├───06_user_guides
│   │       barista_guide.md
│   │       client_guide.md
│   │       glossary.md
│   │       manager_guide.md
│   │       
│   ├───07_jira_tasks
│   │   └───docs
│   │       └───07_jira_tasks
│   │               tasks.md
│   │               
│   └───08_monitoring
│           metrics.md
│           prometheus.yml
│           
├───notes
│       business_context.md
│       
└───sql
    │   monitoring.sql
    │   test_data.sql
    │   
    └───src
            main.py
```

## Контакты
Автор: Svetlana (системный аналитик)  
GitHub: [https://github.com/sveta-zhe]