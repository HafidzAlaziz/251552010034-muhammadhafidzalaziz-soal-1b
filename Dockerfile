FROM nginx:alpine

# ── Build arguments (nilai dikirim dari docker-compose.yml) ──
ARG ORG_NAME
ARG ORG_TAGLINE
ARG ORG_MISSION
ARG ORG_VISION
ARG ORG_FOUNDED
ARG ORG_MEMBERS
ARG ORG_DIVISION
ARG ORG_EMAIL
ARG ORG_LOCATION

# ── Salin file HTML & CSS asli (tidak diubah langsung) ──
COPY html/index.html /usr/share/nginx/html/index.html
COPY html/style.css  /usr/share/nginx/html/style.css

# ── Ganti semua placeholder di dalam image saat build (pakai sed) ──
RUN sed -i \
    -e "s|ORG_NAME_PLACEHOLDER|${ORG_NAME}|g" \
    -e "s|ORG_TAGLINE_PLACEHOLDER|${ORG_TAGLINE}|g" \
    -e "s|ORG_MISSION_PLACEHOLDER|${ORG_MISSION}|g" \
    -e "s|ORG_VISION_PLACEHOLDER|${ORG_VISION}|g" \
    -e "s|ORG_FOUNDED_PLACEHOLDER|${ORG_FOUNDED}|g" \
    -e "s|ORG_MEMBERS_PLACEHOLDER|${ORG_MEMBERS}|g" \
    -e "s|ORG_DIVISION_PLACEHOLDER|${ORG_DIVISION}|g" \
    -e "s|ORG_EMAIL_PLACEHOLDER|${ORG_EMAIL}|g" \
    -e "s|ORG_LOCATION_PLACEHOLDER|${ORG_LOCATION}|g" \
    /usr/share/nginx/html/index.html

# ── Sematkan metadata organisasi ke dalam image ──
LABEL org.name="${ORG_NAME}" \
      org.founded="${ORG_FOUNDED}" \
      maintainer="${ORG_EMAIL}"

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
