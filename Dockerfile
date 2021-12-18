FROM archlinux
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN \
    pacman -Syu && \
    pacman -S curl git python3 python3-pip && \
    pip install --upgrade pip

RUN pacman -S ffmpeg nodejs npm 
WORKDIR /app
COPY . /app/
RUN npm install npx -g
RUN npx prisma generate
RUN npm install
RUN npm run build:prod
CMD [ "node","./build/src/index.js"]
