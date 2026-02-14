# DIRAC MongoDB - TODO

**Project**: MongoDB integration library for DIRAC  
**Location**: `/Users/zhiwang/diraclang/dirac-mongodb/`  
**Parent TODO**: See `/Users/zhiwang/diraclang/dirac/TODO.md`

## ✅ Completed

- [x] **CRUD Operations Library**: Complete MongoDB CRUD implementation
  - **Why**: Enable database operations without config files
  - MONGO_FIND: Query with filter, sort, limit
  - MONGO_INSERT_ONE: Insert single document
  - MONGO_INSERT_MANY: Batch insert
  - MONGO_UPDATE_ONE: Update with filter and upsert option
  - MONGO_UPDATE_MANY: Bulk updates
  - MONGO_DELETE_ONE: Delete single document
  - MONGO_DELETE_MANY: Bulk delete
  - MONGO_COUNT: Count documents with filter
  - MONGO_AGGREGATE: Full aggregation pipeline support
  - Uses environment variables (MONGODB_URI, MONGODB_DATABASE)
  - No config.yml dependency
  
## 🔴 High Priority

### Pending
- [ ] **Port existing mongodb.di**: From dirac-lang/lib/mongodb.di
  - Review existing implementation
  - Ensure proper connection management
  - Handle errors gracefully

- [ ] **Connection operations**:
  - MONGO_CONNECT: Connect with URI
  - MONGO_CLOSE: Clean shutdown
  - Connection pooling support

- [ ] **CRUD operations**:
  - MONGO_INSERT_ONE, MONGO_INSERT_MANY
  - MONGO_FIND, MONGO_FIND_ONE
  - MONGO_UPDATE_ONE, MONGO_UPDATE_MANY
  - MONGO_DELETE_ONE, MONGO_DELETE_MANY

## 🟡 Medium Priority

### Pending
- [ ] **Aggregation pipeline**: Support for complex queries
  - MONGO_AGGREGATE: Run pipeline
  - Common pipeline stages
  - Examples and documentation

- [ ] **Index management**: Create and manage indexes
  - MONGO_CREATE_INDEX
  - MONGO_DROP_INDEX
  - MONGO_LIST_INDEXES

- [ ] **Transaction support**: Multi-document transactions
  - MONGO_START_TRANSACTION
  - MONGO_COMMIT_TRANSACTION
  - MONGO_ABORT_TRANSACTION

- [ ] **Testing**: Integration tests with test database
  - Mock MongoDB server
  - Test all CRUD operations
  - Test error handling

## 🟢 Low Priority / Future

### Pending
- [ ] **Change streams**: Real-time data monitoring
  - Watch collections for changes
  - Integration with dirac-flow queues

- [ ] **GridFS support**: Large file storage
  - Upload/download files
  - Stream operations

- [ ] **Schema validation**: Validate documents before insert
  - JSON Schema support
  - Custom validators

## ✅ Completed

- [x] **Project structure**
  - Created package.json
  - Created lib/index.di
  - Basic README

---

## Notes
- **Last updated**: 2026-02-14
- **Current version**: 0.1.0 (not yet published)
- **Dependencies**: mongodb (peer dependency)
- **Strategy**: Port from dirac-lang/lib, add error handling
