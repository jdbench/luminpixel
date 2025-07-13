FROM node:24-alpine AS builder

WORKDIR /build
COPY . .
RUN npm run build


FROM node:24-alpine

WORKDIR /app

COPY --from=builder /build/.next/standalone ./
COPY --from=builder /build/.next/static ./.next/static
COPY --from=builder /build/public ./public

EXPOSE 3000
ENV PORT=3000
ENV NODE_ENV=production

CMD ["node", "server.js"]