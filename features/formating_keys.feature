Feature: Formatting a string key to RSA format

  Scenario: Format RSA keys that include headers and footers
    Given a file named "private_key.dice" with:
      """
      <%= ensure_is_private_key(configured.private_key) %>
      """
    When I run `rake PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY----- MIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/ EspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9om ZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ov l0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9 kw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t 0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwj Zk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+Utl kjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdP uYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWD yywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7 yq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3 TPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kF taF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik 8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuG MFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/6 2zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8 XsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmB db5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqg jlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5 u8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMO ChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAo kd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndr Qk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbF ZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQ eDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=  -----END RSA PRIVATE KEY-----" config`
    Then the file "private_key" should contain:
      """
      -----BEGIN RSA PRIVATE KEY-----
      MIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/
      EspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9om
      ZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ov
      l0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9
      kw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t
      0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwj
      Zk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+Utl
      kjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdP
      uYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWD
      yywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7
      yq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3
      TPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kF
      taF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik
      8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuG
      MFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/6
      2zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8
      XsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmB
      db5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqg
      jlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5
      u8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMO
      ChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAo
      kd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndr
      Qk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbF
      ZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQ
      eDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=
      -----END RSA PRIVATE KEY-----
      """


  Scenario: Format RSA keys that do not include headers and footers
    Given a file named "private_key.dice" with:
      """
      <%= ensure_is_private_key(configured.private_key) %>
      """
    When I run `rake PRIVATE_KEY="MIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/ EspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9om ZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ov l0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9 kw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t 0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwj Zk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+Utl kjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdP uYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWD yywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7 yq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3 TPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kF taF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik 8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuG MFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/6 2zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8 XsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmB db5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqg jlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5 u8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMO ChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAo kd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndr Qk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbF ZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQ eDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=" config`
    Then the file "private_key" should contain:
      """
      -----BEGIN RSA PRIVATE KEY-----
      MIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/
      EspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9om
      ZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ov
      l0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9
      kw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t
      0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwj
      Zk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+Utl
      kjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdP
      uYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWD
      yywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7
      yq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3
      TPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kF
      taF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik
      8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuG
      MFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/6
      2zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8
      XsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmB
      db5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqg
      jlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5
      u8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMO
      ChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAo
      kd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndr
      Qk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbF
      ZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQ
      eDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=
      -----END RSA PRIVATE KEY-----
      """

  Scenario: Format RSA keys that contain carriage returns
    Given a file named "private_key.dice" with:
      """
      <%= ensure_is_private_key(configured.private_key) %>
      """
    When I run `rake PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/\nEspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9om\nZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ov\nl0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9\nkw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t\n0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwj\nZk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+Utl\nkjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdP\nuYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWD\nyywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7\nyq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3\nTPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kF\ntaF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik\n8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuG\nMFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/6\n2zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8\nXsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmB\ndb5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqg\njlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5\nu8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMO\nChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAo\nkd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndr\nQk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbF\nZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQ\neDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=\n-----END RSA PRIVATE KEY-----" config`
    Then the file "private_key" should contain:
      """
      -----BEGIN RSA PRIVATE KEY-----
      MIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/
      EspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9om
      ZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ov
      l0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9
      kw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t
      0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwj
      Zk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+Utl
      kjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdP
      uYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWD
      yywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7
      yq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3
      TPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kF
      taF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik
      8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuG
      MFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/6
      2zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8
      XsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmB
      db5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqg
      jlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5
      u8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMO
      ChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAo
      kd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndr
      Qk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbF
      ZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQ
      eDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=
      -----END RSA PRIVATE KEY-----
      """

  Scenario: Format RSA keys that are not delimited with spaces
    Given a file named "private_key.dice" with:
      """
      <%= ensure_is_private_key(configured.private_key) %>
      """
    When I run `rake PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----MIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/EspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9omZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ovl0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9kw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwjZk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+UtlkjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdPuYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWDyywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7yq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3TPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kFtaF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuGMFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/62zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8XsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmBdb5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqgjlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5u8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMOChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAokd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndrQk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbFZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQeDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=-----END RSA PRIVATE KEY-----" config`
    Then the file "private_key" should contain:
      """
      -----BEGIN RSA PRIVATE KEY-----
      MIIEogIBAAKCAQEAn4XOc6lV0LZ5j+dBCRH2eiDj6fGlzMIJ7gmSUBF++xLLLAP/
      EspquIMpTSRJFgrg29euExYNVA+DKDn45ckAXnWar/1JLQdWfz+8ybdUH8mAt9om
      ZStvjfVbqS1/kyBBOymo2LZ3BZCuVRR/kiZ3xuwY06VhgKOcCJR8YQjW5hX+U9Ov
      l0fLlE4C1a32GBGkcNU7GTrS4aBlciAtALmRLbU+0rr+XJECYWb7/SFfYaM0qAa9
      kw6FYCfatXclHm2qLaOo8mwlsAdQPpCVyW7R/RrdLgLLkkmzeJacLgjFTLyb894t
      0Y9/4fHy+L+FAmC+Rceka9ZpCb+/V6IcAZDj+QIDAQABAoIBAHugkV0lsLHtmMwj
      Zk2HNEN11evqMJo9DsEBffi7dnNSH07fUgDYClkwnQOByXpht93oiqmT/4RT+Utl
      kjVSzwxljBoz61AQTcKUPNT/VRzFZxIU6IijXvLfYcf80M/OwX7+TDKXRipz9AdP
      uYYkddMeCieMFcJCCZzEppf058arr47r+EpQ2mrD/jbtBbsBi/yJdGtk+qdLROWD
      yywKdUo8xbbD0YzIPQptqCqrvNSfi+O/6eTK3KXmycNP+BQlJ7EWS0VSZeWyzWq7
      yq0mRqbHM9qFWWrKuQvJtbcU1YysBjMLv2//3zZMaI7mATrdioCA+S7X7s3vwRo3
      TPeNzVkCgYEAy/OxIPhwMYD4qwGSbkiKw2IZkLFXg10SHmNciA87it32wON1e9kF
      taF/8e47yvt2MHagGli95zOne0QZN4eF0+HJcbXA5s3jA/S9r9VNS75pFsIWAtik
      8hc4oPKyils+rBCT+w1i+SeiZP1UgBygEQhjj3j7zEUWLeIgWMVE1hMCgYEAyDuG
      MFqrqpb0kCzXiGAB6MyTeqOZXkZML/gHWmMamhI9xXraAeQO3T5NGodIAqkHgN/6
      2zZrgYfYgqJXJZZa46RXUNV5ZoAIW9M6Y9OvtsnRulDnDGgMqxbbTrTOil8xSfa8
      XsKGMC8T5H+VZdl4bm002u9cQylLoXo4/ncvT0MCgYAMAl50tYxNre12jFImAkmB
      db5Roc+oYYuWlH03WcZEyAsmkn4xe7b1Wfwhr8h/jE0KT4Hf60fLXGRJQtpFRcqg
      jlQBSRWBwa/TZM7ikqnJgv3HJEiNhFo6Exn3iDLxKKxJD3TXPJOOXkIWtkAKhyT5
      u8e5BAO3pH3I197Vu0/xVwKBgGmnZv4aydxAvRlaX/w41KkXUXZz3ths9YSWNqMO
      ChpkJ64NTf2Tbfh2CE9INMoakLgC96Y2B/IYUTlVGfDebmUR8XTYv69DPaXeRkAo
      kd48jernB5N3T7/zVpMoOpeu9R4XEHxb3lyMas22OIm+f5qdCze+94sEvkCdcndr
      Qk5rAoGAUt/wU5qw3dOfEKODUSqRsoa3tJPx0SEiaOKq2sibZ1mlG/urfMpXqAbF
      ZavBQUG7TBGzaA4QJsS+dmwaJIP9JfxuzL21mzK+Tefc7uyFhjApJYhvFfoukveQ
      eDaPBD9iMFC8OpKthsoEInVGN+GGLWvDZSwRyB4ce5SzOl+kQ9s=
      -----END RSA PRIVATE KEY-----
      """
