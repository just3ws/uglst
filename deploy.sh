echo --- DEPLOY ---
bundle exec cap production deploy
echo --- MIGRATE --
bundle exec cap production deploy:migrate
echo --- CLEAR CRONTAB ---
bundle exec cap production whenever:clear_crontab
echo --- UPDATE CRONTAB---
bundle exec cap production whenever:update_crontab
echo --- RESTART SIDEKIQ ---
bundle exec cap production sidekiq:restart
echo --- RESTART PUMA ---
bundle exec cap production puma:restart
