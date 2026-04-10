from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, String, Integer, Float, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
import uuid
from datetime import datetime

# ============================================
# 1. Настройка базы данных (SQLite для примера)
# ============================================
DATABASE_URL = "sqlite:///./coffee_shop.db"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Модель заказа (таблица в БД)
class OrderDB(Base):
    __tablename__ = "orders"
    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    user_id = Column(String)
    status = Column(String, default="new")
    total_amount = Column(Float)
    created_at = Column(DateTime, default=datetime.now)

Base.metadata.create_all(bind=engine)

# ============================================
# 2. Pydantic модели (входные и выходные данные)
# ============================================
class OrderItemInput(BaseModel):
    product_id: str
    quantity: int

class OrderInput(BaseModel):
    items: list[OrderItemInput]

class OrderOutput(BaseModel):
    id: str
    status: str
    total_amount: float

# ============================================
# 3. FastAPI приложение
# ============================================
app = FastAPI(title="Coffee Shop API", version="1.0.0")

# Зависимость для получения сессии БД
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# ============================================
# 4. API эндпоинты
# ============================================

@app.post("/orders", response_model=OrderOutput, status_code=201)
async def create_order(order: OrderInput, db: Session = Depends(get_db)):
    """
    Создать новый заказ.
    """
    # Простейшая логика расчета суммы (в реальности — запрос к таблице продуктов)
    total = 0
    for item in order.items:
        total += 180.0 * item.quantity  # заглушка: цена 180 за продукт
    
    # Создаем заказ в БД
    db_order = OrderDB(
        user_id="33333333-3333-3333-3333-333333333333",  # заглушка: клиент
        total_amount=total,
        status="new"
    )
    db.add(db_order)
    db.commit()
    db.refresh(db_order)
    
    return OrderOutput(id=db_order.id, status=db_order.status, total_amount=db_order.total_amount)

@app.get("/orders/{order_id}", response_model=OrderOutput)
async def get_order(order_id: str, db: Session = Depends(get_db)):
    """
    Получить заказ по ID.
    """
    order = db.query(OrderDB).filter(OrderDB.id == order_id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    return OrderOutput(id=order.id, status=order.status, total_amount=order.total_amount)

@app.get("/health")
async def health_check():
    """
    Проверка здоровья сервиса.
    """
    return {"status": "ok"}

# ============================================
# 5. Запуск (для разработки)
# ============================================
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)