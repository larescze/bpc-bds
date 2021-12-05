from django.contrib import admin
from django.urls import path, re_path, include
from django.views.generic.base import TemplateView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include('pentesting.urls')),
    path('api/v1/', include('djoser.urls')),
    path('api/v1/', include('djoser.urls.authtoken')),
    re_path(r'^(?!api).*$',
            TemplateView.as_view(template_name="index.html"), name="entry-point")
]
