# Northwind - Proyecto de Base de Datos

## Estructura del Proyecto

```text
Northwind/
├── NorthwindOLTP/ # Base de datos transaccional
│   ├── Security/
│   │   └── Schemas/
│   │       ├── production.sql
│   │       └── sales.sql
│   ├── Tables/
│   │   ├── production/
│   │   │   ├── categories.sql
│   │   │   ├── products.sql
│   │   │   ├── suppliers.sql
│   │   │   ├── shippers.sql
│   │   │   ├── region.sql
│   │   │   └── territories.sql
│   │   └── sales/
│   │       ├── customers.sql
│   │       ├── customerdemographics.sql
│   │       ├── employees.sql
│   │       ├── employeeterritories.sql
│   │       ├── orders.sql
│   │       └── orderdetails.sql
│   ├── Programmability/
│   │   └── Stored Procedures/
│   │       ├── GetCustomerChangesByRowVersion.sql
│   │       ├── GetDatabaseRowVersion.sql
│   │       ├── GetEmployeeChangesByRowVersion.sql
│   │       ├── GetOrderChangesByRowVersion.sql
│   │       ├── GetProductChangesByRowVersion.sql
│   │       ├── CustOrderHist.sql
│   │       ├── CustOrdersDetail.sql
│   │       ├── CustOrdersOrders.sql
│   │       ├── EmployeeSalesByCountry.sql
│   │       ├── SalesByYear.sql
│   │       ├── SalesByCategory.sql
│   │       └── TenMostExpensiveProducts.sql
│   └── Scripts/
│       ├── clean.data.sql
│       ├── region.data.sql
│       ├── territories.data.sql
│       ├── categories.data.sql
│       ├── suppliers.data.sql
│       ├── shippers.data.sql
│       ├── customers.data.sql
│       ├── customerdemographics.data.sql
│       ├── employees.data.sql
│       ├── employeeterritories.data.sql
│       ├── products.data.sql
│       ├── orders.data.sql
│       ├── orderdetails.data.sql
│       └── Script.PostDeployment.sql
│
└── NorthwindDW2/ # Data Warehouse
    ├── Security/
    │   └── staging.sql
    ├── Tables/
    │   ├── dbo/
    │   │   └── PackageConfig.sql
    │   ├── staging/
    │   │   ├── Categories.sql
    │   │   ├── Customers.sql
    │   │   ├── Employees.sql
    │   │   ├── OrderDetails.sql
    │   │   ├── Orders.sql
    │   │   ├── Products.sql
    │   │   ├── Region.sql
    │   │   ├── Shippers.sql
    │   │   ├── Suppliers.sql
    │   │   └── Territories.sql
    │   ├── dim/
    │   │   ├── DimDate.sql
    │   │   ├── DimCustomer.sql
    │   │   ├── DimProduct.sql
    │   │   ├── DimEmployee.sql
    │   │   ├── DimShipper.sql
    │   │   └── DimGeography.sql
    │   └── fact/
    │       └── FactSales.sql
    ├── Programmability/
    │   └── Stored Procedures/
    │       ├── DW_MergeDimCustomer.sql
    │       ├── DW_MergeDimDate.sql
    │       ├── DW_MergeDimEmployee.sql
    │       ├── DW_MergeDimGeography.sql
    │       ├── DW_MergeDimProduct.sql
    │       ├── DW_MergeDimShipper.sql
    │       ├── DW_MergeFactSales.sql
    │       ├── GetLastPackageRowVersion.sql
    │       └── UpdateLastPackageRowVersion.sql
    └── Scripts/
        ├── PackageConfig.data.sql
        ├── DimDate.data.sql
        ├── PatchDimDate.data.sql
        └── Script.PostDeployment.sql
```

---

# NorthwindOLTP - Base de Datos Transaccional

**Propósito:** Gestionar operaciones diarias del negocio (ventas, inventario, clientes).

## Schemas

| Schema | Tablas |
|--------|--------|
| `production` | categories, products, suppliers, shippers, region, territories |
| `sales` | customers, employees, orders, orderdetails, customerdemographics, employeeterritories |

## Características

| Elemento | Descripción |
|----------|-------------|
| **Normalización** | 3NF (Third Normal Form) |
| **RowVersion** | Control de cambios para ETL incremental |
| **Índices** | Optimizados para transacciones (INSERT/UPDATE/DELETE) |
| **Stored Procedures** | Operaciones de negocio y extracción de cambios |

## Stored Procedures Principales

| Procedimiento | Propósito |
|---------------|-----------|
| `Get*ChangesByRowVersion` | Extracción incremental para ETL |
| `GetDatabaseRowVersion` | Obtener versión actual de la BD |
| `CustOrderHist` | Historial de órdenes por cliente |
| `SalesByYear` | Ventas agregadas por año |

---

# NorthwindDW2 - Data Warehouse

**Propósito:** Análisis de datos y reporting (business intelligence).

## Modelo: Star Schema

| Componente | Tablas |
|------------|--------|
| **Hechos** | 1 tabla (`FactSales`) |
| **Dimensiones** | 6 tablas (`Date`, `Customer`, `Product`, `Employee`, `Shipper`, `Geography`) |

## Schemas

| Schema | Propósito |
|--------|-----------|
| `staging` | Tablas de origen (copia de OLTP) |
| `dim` | Tablas dimensión |
| `fact` | Tabla de hechos |
| `dbo` | Tablas de control (`PackageConfig`) |

## Características

| Elemento | Descripción |
|----------|-------------|
| **Modelo** | Star Schema desnormalizado |
| **SCD** | Tipo 1 (sobrescritura, sin historial) |
| **ETL** | Incremental por `RowVersion` |
| **Persisted Column** | `LineTotal` precalculado |

## Flujo ETL

```text
OLTP → Staging → Dimensiones → Hechos
        ↓             ↓
   RowVersion     Merge SCD1
        ↓
PackageConfig (control de versión)
```

---

## Comparación Rápida

| Aspecto | OLTP | DW |
|---------|------|-----|
| **Propósito** | Transacciones diarias | Análisis y reporting |
| **Modelo** | Normalizado (3NF) | Dimensional (Star) |
| **Tablas** | +12 tablas | 7 tablas + 10 staging |
| **Actualización** | INSERT/UPDATE/DELETE | Solo INSERT (Merge) |
| **Consultas** | Transaccionales (pocos registros) | Agregaciones (muchos registros) |
| **ETL** | Fuente de datos | Destino de datos |

---

## Dependencias

- SQL Server 2017 o superior
- Modo SQLCMD en Visual Studio (para post-deployment)

---

## Orden de Publicación

1. **NorthwindOLTP** (primero)
2. **NorthwindDW2** (después de OLTP)

```sql
-- Ejecutar después de publicar ambos proyectos
-- OLTP: Datos de origen
-- DW: ETL para poblar dimensiones y hechos
```

# Integrantes 
- Ivan Rene Ccama Mamani
- Ezequiel Gerstel Bodoha
- Ana Belen Hidalgo Macias
