from django.contrib import admin
from django.urls import path, re_path, include
from django.views.generic.base import TemplateView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include('pentesting.urls')),
    re_path(r'^.*$',
            TemplateView.as_view(template_name="index.html"), name="entry-point")
]
