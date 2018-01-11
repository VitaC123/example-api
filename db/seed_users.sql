INSERT INTO users(uri, slug, gravatar_id, username, display_name, release_count, module_count, created_at, updated_at)
VALUES
  ('/v3/users/001john', '001john', '4dbab6720a744e44beb0999266bfe6a2', '001john', '001john', '0', '0', '2014-11-06 06:33:31 -0800', '2014-11-06 06:33:53 -0800'),
  ('/v3/users/030', '030', '4ef03c2bf8d8689527903212d96fb45b', '030', '030', '17', '4', '2016-05-16 06:57:37 -0700', '2017-08-31 01:01:42 -0700'),
  ('/v3/users/0cloud', '0cloud', 'e8cf2886ea616a5e99753ae5aadbb6c9', '0cloud', '0cloud', '1', '1', '2014-10-16 15:37:44 -0700', '2014-10-16 15:37:59 -0700')
ON CONFLICT (username)
DO NOTHING
RETURNING *;
