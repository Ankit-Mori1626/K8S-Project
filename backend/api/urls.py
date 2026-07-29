from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import health_check, ItemViewSet

router = DefaultRouter()
router.register('items', ItemViewSet)

urlpatterns = [
    path('health/', health_check, name='health-check'),
    path('', include(router.urls)),
]
